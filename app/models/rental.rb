class Rental < ApplicationRecord
  after_save :recalculate_customer_stats_profile
  after_save :produce_kafka_message

  belongs_to :customer, counter_cache: true
  belongs_to :inventory

  has_one :store, through: :inventory
  has_one :film, through: :inventory

  def recalculate_customer_stats_profile
    RecalculateCustomerStatsProfileJob.perform_later(customer_id)
  end

  def produce_kafka_message
    Karafka.produce.produce_sync(
      topic: 'rentals',
      payload: {
        rental: Api::V1::RentalPresenter.new(self).as_json
      }.to_json
    )
  end
end
