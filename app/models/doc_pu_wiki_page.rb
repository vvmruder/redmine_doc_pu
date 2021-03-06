require 'latex_flags'
require 'latex_wiki_page'

class DocPuWikiPage < ActiveRecord::Base
	unloadable
	after_initialize :get_flags_from_str
	before_save :set_flags_to_str

	belongs_to :wiki_page
	belongs_to :doc_pu_document
	validates_presence_of :wiki_page_id, :doc_pu_document_id
	
	include ModuleLatexFlags
	include ModuleLatexWikiPage

	def to_latex()
		self.chapter_name = (self.chapter_name != '' ? self.chapter_name : self.wiki_page.title)
		# Get document flags
		if self.use_doc_flags && !self.doc_pu_document.nil?
			ModuleLatexFlags::FLAGS.each do |m, _|
				self.send(m.to_s + '=', self.doc_pu_document.send(m))
			end
		end
		super
	end
	
	def get_flags_from_str
		self.flags_from_str(self.flags)
		true
	end

	def set_flags_to_str
		self.flags = self.flags_to_str()
		true
	end

end
