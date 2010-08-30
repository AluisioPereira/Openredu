# CommunityEngine
module CommunityEngine
  module ActiveRecordExtensions
    def prepare_options_for_attachment_fu(options)
      attachment_fu_options = options.symbolize_keys.merge(
        {:storage => options['storage'].to_sym, 
         :max_size => options['max_size'].to_i.megabytes,
         :processor => (options['processor'] && options['processor'].to_sym)
        })  
    end      
  end  


  
end

ActiveRecord::Base.send(:extend, CommunityEngine::ActiveRecordExtensions)

require 'rails_asset_extensions'