class ShardRecord < ApplicationRecord
  self.abstract_class = true

  connects_to shards: {
    shard_one: { writing: :shard_one },
    shard_two: { writing: :shard_two },
    shard_three: { writing: :shard_three }
  }
end