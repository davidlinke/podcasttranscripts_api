module Resolvers
  class TranscriptsSearch < Resolvers::BaseResolver

    scope { Episode.all }

    type [Types::EpisodeType]

    option :podcast_id, type: types.Int, with: :apply_id_filter
    option :transcript_filter, type: types.String, with: :apply_transcript_filter

    def apply_id_filter(scope, value)
      scope.where podcast_id: value
    end

    def apply_transcript_filter(scope, value)
      scope.where 'LOWER(transcript) LIKE LOWER(?)', escape_search_term(value)
    end

  end
end