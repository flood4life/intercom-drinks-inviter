require_relative 'spec_helper'
require_relative '../lib/customer_drinks_invite_predicate'

describe CustomerDrinksInvitePredicate do
  describe 'when maximum distance is negative' do
    it 'raises an ArgumentError' do
      error = assert_raises ArgumentError do
        CustomerDrinksInvitePredicate.new(max_distance: -1)
      end
      assert_match(/max_distance should be a non-negative number, got -1:Integer/, error.message)
    end
  end

  describe 'when maximum distance is not a number' do
    it 'raises an ArgumentError' do
      error = assert_raises ArgumentError do
        CustomerDrinksInvitePredicate.new(max_distance: '1')
      end
      assert_match(/max_distance should be a non-negative number, got 1:String/, error.message)
    end
  end

  describe 'when distance is negative' do
    it 'raises an ArgumentError' do
      error = assert_raises ArgumentError do
        predicate = CustomerDrinksInvitePredicate.new(max_distance: 1)
        predicate.call(-1)
      end
      assert_match(/distance should be a non-negative number, got -1:Integer/, error.message)
    end
  end

  describe 'when distance is not a number' do
    it 'raises an ArgumentError' do
      error = assert_raises ArgumentError do
        predicate = CustomerDrinksInvitePredicate.new(max_distance: 1)
        predicate.call('1')
      end
      assert_match(/distance should be a non-negative number, got 1:String/, error.message)
    end
  end

  describe 'when distance is less or equal than the maximum distance' do
    it 'returns true' do
      predicate = CustomerDrinksInvitePredicate.new(max_distance: 200e3)
      assert_equal true, predicate.call(50)
      assert_equal true, predicate.call(50e3)
      assert_equal true, predicate.call(200e3)
    end
  end

  describe 'when distance is greater than the maximum distance' do
    it 'returns false' do
      predicate = CustomerDrinksInvitePredicate.new(max_distance: 200e3)
      assert_equal false, predicate.call(200e3 + 1)
      assert_equal false, predicate.call(Float::INFINITY)
    end
  end
end