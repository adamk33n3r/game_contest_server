module Uploadable
  extend ActiveSupport::Concern
  included do
    validates_presence_of :file_location
  end
  def upload=(uploaded_io)
    if uploaded_io.nil?
      "Error"
    else
      ran_str = rand(36**20).to_s(36)
      time_no_spaces = Time.now.to_s.gsub(/\s/, '_')
      file_location = Rails.root.join('code',
                                      self.class.to_s.pluralize.downcase,
                                      Rails.env,
                                      ran_str + "_" + time_no_spaces).to_s
      IO::copy_stream(uploaded_io, file_location)
      self.file_location = file_location
    end
  end
end