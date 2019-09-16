module Resolvers
    class BaseResolver
      include SearchObject.module(:graphql)
  
      def escape_search_term(term)
        "%#{term.gsub(/\s+/, '%')}%"
      end
    end
  end