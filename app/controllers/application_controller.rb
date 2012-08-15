class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :default_format_json

  def default_format_json
    if request.headers["HTTP_ACCEPT"].nil? && params[:format].nil?
      request.format = "json"
    end
  end

  def to_json_hash_without_dates(object)
    json = ActiveSupport::JSON.decode object.to_json
    remove_date_fields_from_hash json
    json
  end

  private
  def remove_date_fields_from_hash(hash)
    hash.except!('created_at', 'updated_at')
    hash.each do |k, v|
      if v.class == Hash
        remove_date_fields_from_hash(v)
      end
      if v.class == Array
        v.each do |element|
          if element.class == Hash
            remove_date_fields_from_hash(element)
          end
        end
      end
    end
  end
end
