# DocPu plugin
require 'redmine'

# Patches to the Redmine core. Will not work in development mode
require_dependency 'wiki_page_patch'

Rails.logger.info 'Loading DocPu plugin...'

Redmine::Plugin.register :redmine_doc_pu do
	name 'Redmine DocPu plugin'
	author 'Christian Raschko'
	description 'A wiki export and document publishing tool, sponsored by: ATV-Elektronik and modified for further use by: GIS-Fachstelle BL'
	version '2.0.0'
	url 'https://github.com/vvmruder/redmine_doc_pu'
	
	# Settings
	settings :default => {
               'latex_bin' => 'pdflatex',
               'makeindex_bin' => 'makeindex',
               'template_dir' => 'plugins/redmine_doc_pu/templates'
           },
		:partial => 'settings/doc_pu_settings'

	# Redmine version
	requires_redmine :version_or_higher => '3.2.0'

	# Create project module
	project_module :doc_pu do
		permission :doc_pu_view, {:doc_pu => [:index, :open], :doc_pu_wiki => [:index]}
		permission :doc_pu_build, :doc_pu => [:build, :build_remote, :clean, :clean_remote, :code]
		permission :doc_pu_edit, {:doc_pu => [:new, :edit, :delete, :template], :doc_pu_wiki => [:new, :edit, :delete, :edit_order]}
	end

	# Add a new item to the project menu
	menu :project_menu, :doc_pu_menu, {:controller => 'doc_pu', :action => 'index'},
		:caption => :menu_publish, :after => :wiki, :param => :project_id
end
