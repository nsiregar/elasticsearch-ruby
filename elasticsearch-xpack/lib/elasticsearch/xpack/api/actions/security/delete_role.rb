# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#	http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

module Elasticsearch
  module XPack
    module API
      module Security
        module Actions

          # Remove a role from the native realm
          #
          # @option arguments [String] :name Role name (*Required*)
          # @option arguments [Boolean] :refresh Refresh the index after performing the operation
          #
          # @see https://www.elastic.co/guide/en/x-pack/current/security-api-roles.html#security-api-delete-role
          #
          def delete_role(arguments={})
            raise ArgumentError, "Required argument 'name' missing" unless arguments[:name]

            valid_params = [ :refresh ]

            method = Elasticsearch::API::HTTP_DELETE
            path   = "_security/role/#{arguments[:name]}"
            params = Elasticsearch::API::Utils.__validate_and_extract_params arguments, valid_params
            body   = nil

            if Array(arguments[:ignore]).include?(404)
              Elasticsearch::API::Utils.__rescue_from_not_found { perform_request(method, path, params, body).body }
            else
              perform_request(method, path, params, body).body
            end
          end
        end
      end
    end
  end
end
