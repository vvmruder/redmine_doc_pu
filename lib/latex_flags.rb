module ModuleLatexFlags

	# Latex flags
	FLAGS = {
		:latex_add_chapter => false,
		:latex_remove_macro => true,
		:latex_code => true,
		:latex_page_ref => true,
		:latex_footnote => true,
		:latex_index_emphasis => true,
		:latex_index_importance => true,
		:latex_table_border => true,
		:latex_image_ref => false,
		:latex_list_of_listings => false,
		:latex_list_of_figures => false,
		:latex_list_of_tables => false,
		:latex_table_of_contents => false,
		:latex_generate_index => false
	}
	
	
	# Create flag attributes
	ModuleLatexFlags::FLAGS.each do |m, _|
		attr_accessor m
	end

	
	# Serialize flags
	def flags_to_str()
		flags = Hash.new
		ModuleLatexFlags::FLAGS.each do |m, _|
			flags[m] = (self.send(m).nil? ? false : self.send(m))
		end
		flags.to_a.join(',')
	end

	
	# Deserialize flags
	def flags_from_str(str)
		# Load flag values
		unless str.nil?
			flags = Hash[*str.split(',')]
			ModuleLatexFlags::FLAGS.each do |m, _|
				self.send(m.to_s + '=', flags[m.to_s] == 'true')
			end
		end
		
		# Set default flag values
		ModuleLatexFlags::FLAGS.each do |m, v|
			self.send(m.to_s + '=', v) if self.send(m).nil?
		end
	end
	
end
