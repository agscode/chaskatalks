class Ticket < ApplicationRecord
  include Dateable
end

class Order < ApplicationController
  include Dateable
end

class Claim
  DATEABLE_COLUMN_NAME = 'created_at'
  include Dateable
end

Claim.by_date(date_range, 'update_at')