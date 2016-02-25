require 'redcloth'

module RedCloth::Formatters::LATEX_EX
	include RedCloth::Formatters::LATEX
	def td(opts)
		puts opts[:text]
    if opts[:text]
      if opts[:text].include? "\n"
        opts[:text] = opts[:text].gsub! "\n", "\\par"
      end
      if opts[:text].include? '&'
        opts[:text] = opts[:text].gsub! '&', '\\\\\\&'
      end
      if opts[:text].include? '%'
        opts[:text] = opts[:text].gsub! '%', '\\\\%'
      end
		end

		opts[:text] = "\\textbf{#{opts[:text]}}" unless opts[:th].nil?
		column = @table_row.size
		if opts[:colspan]
			vline = (draw_table_border_latex ? '|c|' : 'c')
			opts[:text] = "\\multicolumn{#{opts[:colspan]}}{#{vline}}{#{opts[:text]}}"
		end
		if opts[:rowspan]
			@table_multirow_next[column] = opts[:rowspan].to_i - 1
			opts[:text] = "\\multirow{#{opts[:rowspan]}}{*}{#{opts[:text]}}"
		end
		@table_row.push(opts[:text])
    ''
	end

	def table_close(opts)
		output = "\\begin{savenotes}\n"
		output << "\\begin{table}[H]\n"
		output << "  \\centering\n"
		cols = 'X' * @table[0].size if not draw_table_border_latex
		cols = '|' + 'X|' * @table[0].size if draw_table_border_latex
		output << "\\begin{minipage}{\\linewidth}\n"
		output << "  \\begin{tabularx}{\\textwidth}{#{cols}}\n"
		output << "   \\hline \n" if draw_table_border_latex
		@table.each do |row|
			hline = (draw_table_border_latex ? "\\hline" : '')
			output << "    #{row.join(' & ')} \\\\ #{hline} \n"
		end
		output << "  \\end{tabularx}\n"
    output << "  \\caption{}\n"
		output << "  \\end{minipage}\n"
		output << "\\end{table}\n"
		output << "\\end{savenotes}\n"
		output
	end

	def image(opts)
		opts[:alt] = opts[:src]
		# Don't know how to use remote links, plus can we trust them?
		return '' if opts[:src] =~ /^\w+\:\/\//
		# Resolve CSS styles if any have been set
		styling = opts[:class].to_s.split(/\s+/).collect { |style| latex_image_styles[style] }.compact.join ','
		# Build latex code
		[ "\\begin{figure}[#{(opts[:align].nil? ? 'H' : 'htb')}]",
		  "  \\centering",
		  "  \\lwincludegraphics[#{styling}]{#{opts[:src]}}",
		 ("  \\caption{#{escape opts[:title]}}" if opts[:title]),
		 ("  \\label{#{opts[:alt]}}" if opts[:alt]),
		  "\\end{figure}",
		].compact.join "\n"
	end
	
end

module RedClothExtensionLatex
  # Solution for RegEx:
  # http://stackoverflow.com/questions/12493128/regex-replace-text-but-exclude-when-text-is-between-specific-tag

	def latex_code(text)
		text.gsub!(/<pre>(.*?)<\/pre>/im) do |_|
			code = $1
			code.match(/<code\s+class="(.*)">(.*)<\/code>/im)
			lang = '{}'
			unless $1.nil?
				code = $2
				lang = "{#{$1}}"
      end
      minted_settings = %W(mathescape linenos numbersep=5pt frame=lines framesep=2mm tabsize=4 fontsize=\\footnotesize breaklines breakanywhere)
                            .join(",")
			if lang == '{}'
				latex_code_text = "<notextile>\n\\begin{code}\n\\begin{minted}\n[#{minted_settings}]\n#{lang}\n#{code}\n\\end{minted}\n\\caption{}\n\\end{code}\n</notextile>\n"
			else
				latex_code_text = "<notextile>\n\\begin{code}\n\\begin{minted}\n[#{minted_settings}]\n#{lang}\n#{code}\n\\end{minted}\n\\caption{}\n\\end{code}\n</notextile>\n"
      end
      latex_code_text
		end
	end

	def latex_page_ref(text)
		text.gsub!(/(\s|^)\[\[(.*?)(\|(.*?)|)\]\]/i) do |_|
			var = $2
			label = $4
			"<notextile> #{label} \\ref{page:#{var}}</notextile>"
		end
	end

	def latex_image_ref(text)
		text.gsub!(/(\s|^)\{\{!(.*?)!\}\}/i) do |_|
			var = $2
			"<notextile> \\ref{#{var}}</notextile>"
		end
	end

	def latex_footnote(text)
		notes = {}
		# Extract and delete footnote 
		text.gsub!(/fn(\d+)\.\s+(.*)/i) do |_|
			notes[$1] = $2
      ''
    end
		# Add footnote
		notes.each do |fn, txt|
			text.gsub!(/(\w+)\[#{fn}\]/i) do |_|
				"<notextile>#{$1}\\footnote{#{txt}}</notextile>"
			end
		end
	end

	def latex_index_emphasis(text)
    text.gsub!((/(?!<notextile[^>]*?>)(\s_(\w.*?)_)([^<])(?![^<]*?<\/notextile>)/im)) do |_|
      var = $1
      "#{var} <notextile>\\index{#{var.tr '_', ''}}</notextile>"
    end
	end

	def latex_index_importance(text)
		text.gsub!(/(?!<notextile[^>]*?>)(\s\*(\w.*?)\*)([^<])(?![^<]*?<\/notextile>)/im) do |_|
			var = $1
			"#{var} <notextile>\\index{#{var.tr '*', ''}}</notextile>"
		end
	end

  def latex_remove_macro(text)
    text.gsub!(/(?!<notextile[^>]*?>)((\s|^)\{\{(.*?)\}\})([^<])(?![^<]*?<\/notextile>)/i) do |_|
      ''
    end
  end
end

# Include rules
RedCloth.include(RedClothExtensionLatex)

class TextileDocLatex < RedCloth::TextileDoc
	attr_accessor :draw_table_border_latex
	
	def to_latex( *rules )
		apply_rules(rules)
		to(RedCloth::Formatters::LATEX_EX)
	end
end


