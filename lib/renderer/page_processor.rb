module Playgroundbook
  class PageProcessor
    def strip_extraneous_newlines(page_contents)
      # Three cases we need to look for:
      # - Extraneous newlines before /*:
      # - Extraneous newlines after */
      # - Extraneous newlines either before or after //:
      page_contents
        .gsub(/\n+\/\*:/, "\n/*:")
        .gsub(/\*\/\n+/, "*/\n")
        .split(/(\/\/:.*$)\n*/).join("\n") # Important to do this before the next line, because it adds newlines before //: comments.
        .gsub(/\n+\/\/:/, "\n//:")
    end

    def extract_live_view(page_contents)
        # Looks for //// LiveView separators.
        split_file = page_contents.split(/\/\/\/\/ LiveView/)
        puts "------"
        puts split_file
        puts "------"
        purged_content = split_file.drop(1).map(&:strip)
        live_view = split_file[2]

        {
          purged_content: purged_content,
          live_view: live_view
        }
    end
  end
end
