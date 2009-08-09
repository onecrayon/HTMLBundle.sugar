HTMLBundle.sugar for Espresso
=============================

The HTMLBundle.sugar adds the majority of the actions and snippets from the default Textmate HTML Bundle to Espresso, including:

* Decode entities in selection
* Encrypt selection (ROT 13)
* URL un/escape selection
* Strip HTML from selection
* Wrap in <?= ... ?>

(Note that some Textmate HTML Bundle actions are included in [TEA for Espresso](http://github.com/onecrayon/tea-for-espresso/), hence this abridged list.)

### Installation

**As of 1.0.1 this sugar requires TEA 1.0b18 or higher; please make sure to upgrade your version of TEA as Espresso 1.0.5 ships with 1.0b12**

If you have git installed, run the following commands to install HTMLBundle.sugar:

    cd ~/Library/Application\ Support/Espresso/Sugars
    git clone git://github.com/onecrayon/HTMLBundle.sugar.git HTMLBundle.sugar

Otherwise, visit the [Downloads tab](http://github.com/onecrayon/HTMLBundle.sugar/downloads), download the latest version as a zip, and double click to install.

**A note:** If you have previously installed HTMLBundle.sugar, you may need to manually move it to the trash before you can double click install it. As of Espresso 1.0.5, Espresso is still not capable of replacing old sugars.

### Errata

HTMLBundle.sugar actions and snippets are all powered by TEA for Espresso.  **This sugar requires TEA 1.0b18 or higher** (the default version of TEA bundled with Espresso 1.0.5 is TEA 1.0b12).

If you have any requests or stumble across any bugs (after upgrading to TEA 1.0b18+), please feel free to [file an issue](http://github.com/onecrayon/HTMLBundle.sugar/issues)!