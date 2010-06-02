begin
  require_library_or_gem "redcloth" unless Object.const_defined?(:RedCloth)
rescue LoadError
  nil
end

require 'acts_as_textiled'
ActiveRecord::Base.send(:include, Err::Acts::Textiled)
