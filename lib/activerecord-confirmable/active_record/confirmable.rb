module ActiveRecord
	module Confirmable
		extend ActiveSupport::Concern

		included do
			validates_acceptance_of :confirmed
			after_rollback :check_confirming
		end

	  def check_confirming
			errors.messages.delete( :confirmed )
			self.confirmed = errors.empty? ? '1' : '' if self.confirmed
	  end

		def confirmation?
			!self.confirmed.blank?
		end
	end
end
