module DocPuWikiHelper

	def acronym_info_tag(str)
		"<abbr title=\"#{str}\">(?)</abbr>".html_safe
	end
	
end
