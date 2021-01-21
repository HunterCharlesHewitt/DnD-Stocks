class Company < ApplicationRecord
    serialize :minute_stocks_robot,Array
    serialize :day_stocks_robot,Array
    serialize :minute_stocks_human,Array
    serialize :day_stocks_human,Array
    serialize :minute_stocks_elf,Array
    serialize :day_stocks_elf, Array
end
