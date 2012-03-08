#!/usr/bin/env python

'''
@author: Sergey Chikuyonok (serge.che@gmail.com)
'''
from subprocess import Popen, PIPE
import os, sys

import re

def replace_or_append(img_tag, attr_name, attr_value):
	"""
	Replaces or adds attribute to the tag
	@type img_tag: str
	@type attr_name: str
	@type attr_value: str
	"""
	if attr_name in img_tag.lower():
		# attribute exists
		re_attr = re.compile(attr_name + r'=([\'"])(.*?)\1', re.I)
		return re.sub(re_attr, lambda m: '%s=%s%s%s' % (attr_name, m.group(1), attr_value, m.group(1)), img_tag)
	else:
		return re.sub(r'\s*(\/?>)$', ' ' + attr_name + '="' + attr_value + r'" \1', img_tag)

def find_images(text):
	"""
	Find image tags in selection
 	@return Image tags and their indexes inside editor source
	"""
	imgRE = re.compile(r'<img (?:[-_a-zA-Z0-9:]+=(?:".*?(?<!\\)"|\'.*?(?<!\\)\'|\S+)\s*)+/?>', re.I)
	
	images = []
	for match in imgRE.finditer(text):
		images.append({
			'start': match.start(),
			'end': match.end(),
			'tag': match.group(0)
		})
	
	return images

def get_image_size(img):
	"""
	Returns size of image in <img>; tag
 	@param img: Image tag
	@return Dictionary with <code>width</code> and <code>height</code> attributes
	"""
	m = re.search(r'src=(["\'])(.+?)\1', img, re.IGNORECASE)
	if m:
		src = get_absolute_uri(m.group(2))
		if not src:
			return None
		try:
			raw_output = Popen('sips -g pixelWidth -g pixelHeight "%s"' % src, stdout=PIPE, shell=True).communicate()[0]
			return {
				'width': re.search(r'pixelWidth:\s*(\d+)', raw_output).group(1),
				'height': re.search(r'pixelHeight:\s*(\d+)', raw_output).group(1)
			}
		except:
			pass
		
	return None

def get_absolute_uri(img_path):
	file_uri = os.environ['EDITOR_PATH']
	
	if img_path[0] == '/':
		img_path = img_path[1:]
	
	while True:
		head, tail = os.path.split(file_uri)
		if not head or head == '/': break # reached the top
			
		abs_image_path = os.path.join(head, img_path)
		abs_image_path = os.path.normpath(abs_image_path)
		if os.path.exists(abs_image_path):
			return os.path.join(abs_image_path)
		
		if head == file_uri: break # infinite loop protection
		file_uri = head
		
	return None

# Actual script
text = sys.stdin.read()
images = find_images(text)
for image in reversed(images):
	size = get_image_size(image['tag'])
	if size:
		new_tag = replace_or_append(image['tag'], 'width', size['width'])
		new_tag = replace_or_append(new_tag, 'height', size['height'])
		
		text = text[0:image['start']] + new_tag + text[image['end']:]

sys.stdout.write(text)
