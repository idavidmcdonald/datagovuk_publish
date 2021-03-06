require 'ckan/modules/url_builder'
require 'ckan/modules/pagination'
require 'open-uri'

module CKAN
  module V26
    class Client
      include CKAN::Modules::URLBuilder
      include CKAN::Modules::Pagination

      LIST_ORGANIZATION_PATH = "/api/3/action/organization_list".freeze
      SHOW_ORGANIZATION_PATH = "/api/3/action/organization_show".freeze
      SEARCH_DATASET_PATH = "/api/3/search/dataset".freeze
      SHOW_DATASET_PATH = "/api/3/action/package_show".freeze

      def initialize(base_url:)
        @base_url = URI(base_url)
      end

      def list_organization
        url = build_url(path: LIST_ORGANIZATION_PATH)
        JSON.parse(url.read)["result"]
      end

      def show_organization(id:)
        url = build_url(path: SHOW_ORGANIZATION_PATH, params: { id: id })
        JSON.parse(url.read)["result"]
      end

      def search_dataset(fl:)
        depaginate(build_url(path: SEARCH_DATASET_PATH,
                             params: { rows: 1000, fl: fl.join(",") }))
      end

      def show_dataset(id:)
        url = build_url(path: SHOW_DATASET_PATH, params: { id: id })
        JSON.parse(url.read)["result"]
      end
    end
  end
end
