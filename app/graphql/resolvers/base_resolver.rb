module Resolvers
    class BaseResolver
      include SearchObject.module(:GraphQL)
  
      def escape_search_term(term)
        "%#{term.gsub(/\s+/, '%')}%"
      end
    end
  end