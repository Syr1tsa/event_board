class ApplicationRecord < ActiveRecord::Base
  REGEX_FOR_EMAIL = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  self.abstract_class = true
end
