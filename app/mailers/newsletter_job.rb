class NewsletterJob < Struct.new(:newsletter)
  def batch_size
    200
  end

  def perform
    Follower.scoped_by_is_subscribe(true).find_in_batches(batch_size: batch_size) do |subscribing_followers|
      CustomerMailer.subscribe_newsletter(newsletter, subscribing_followers).deliver
    end
  end
end