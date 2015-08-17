DocPu, Document publishing plugin
=================================

This plugin enables PDF export and generation for Redmine wiki pages using the LaTeX typesetting system. But it is even more than an simple PDF exporter since it uses the LaTeX text and figure layout engine.

Originally this redmine plugin was created by Christian Raschko. It was intended to be used for 1.1.x verisions of redmine and below. Since this plugin creates eye catching documents and of cause can be extended a little more I decided to get the code and make it valid for use in __redmine 2.6.x__ versions.

It is still in development mode. So I think all features as described below should work. But there are still some little bugs.

Features
========

* Merge multiple wiki pages to one single PDF document
* Automatically generate title page and table of content
* Automatically generate an index from all strong or italic words
* Wiki page references are translated to PDF links
* Code highlighting is supported for Redmine code block (uses minted + pygments)
* Solid table boarders __can__ be drawn
* Add chapter for every wiki page
* Remove Redmine macros, eg. {{toc}}
* Convert wiki footnotes to LaTeX footnotes
* Use floating or fixed images
* ...

Dependencies
============

DocPu uses and extends the [RedCloth4](http://redcloth.org/) LaTeX export module, which is a converter for the Textile markup language. The system which hosts redmine should also have an working installation of LaTeX. Since the code highlighting is done by pygments, this python package should be installed too. This version of the plugin is made to work with __redmine 2.6.x__. This indicate a dependency to [rails 3.2](http://guides.rubyonrails.org/v3.2.21/3_2_release_notes.html) as you can see [here](http://www.redmine.org/projects/redmine/wiki/RedmineInstall#Ruby-interpreter). For older redmines you can refer to this [version](http://www.redmine.org/plugins/redmine_doc_pu) of the plugin.

Installing RedCloth4
--------------------

Currently Redmine uses RedCloth3, so you have to additionally install RedCloth4.
The simplest solution is by typing gem install RedCloth, but this only works if you have a compiler set-up, since some parts are written in C code.
For windows users a pre compiled gem package can be downloaded from the repository. Download it first and install it via eg. gem install RedCloth-4.2.2-x86-mswin32-60.gem

LaTeX
-----

### Installing LaTeX


On Windows machines you can download and install the [MikTex](http://miktex.org/) LaTeX distribution. Four all other platforms see http://www.latex-project.org/ftp.html.

DocPu Requires the following LaTeX packages, be sure you have them installed as well:

* tabularx
* listings
* ulem
* graphicx
* float
* multirow
* makeidx
* hyperref
* minted
* caption

### Testing LaTeX

It's a good idea to test the LaTeX installation before using it with DocPu. Create an empty folder and copy the article_en_tcfi.tex file from the plugin template directory(redmine_doc_pu/templates) to it. Now create an empty file named document.tex, afterwards you can compile the document with pdflatex article_en_tcfi.tex (or path_to_latex/pdflatex). The file should compile successful with the message:

```
Output written on article_en_tcfi.pdf (1 page, 28874 bytes).
```

Installing DocPu plugin
-----------------------

Please refer this [Guide](http://www.redmine.org/projects/redmine/wiki/Plugins) to learn how to install an redmine Plugin. Note that you should follow the steps for the 2.x version.

### Configure DocPu plugin

Goto Redmine administration and select Plugins. You should see the DocPu plugin installed. Now select Configure and fill in the correct LaTeX and makeindex binary paths.
