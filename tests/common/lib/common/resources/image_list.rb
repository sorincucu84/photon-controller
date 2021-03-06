# Copyright 2015 VMware, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, without warranties or
# conditions of any kind, EITHER EXPRESS OR IMPLIED. See the License for the
# specific language governing permissions and limitations under the License.

module EsxCloud
  class ImageList

    attr_reader :items

    # @param [String] json
    # @return [ProjectList]
    def self.create_from_json(json)
      payload = JSON.parse(json)

      unless payload.is_a?(Hash) && payload["items"].is_a?(Enumerable)
        raise UnexpectedFormat, "Invalid image list: #{payload}"
      end

      items = payload["items"].map do |item|
        Image.create_from_hash(item)
      end

      new(items)
    end

    # @param [Array<Project>] items
    def initialize(items)
      @items = items
    end

  end
end
