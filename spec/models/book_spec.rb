require 'rails_helper'

RSpec.describe Book do

  let(:book) { Fabricate.build(:book) }

  describe "#lend_to" do

    before do
      allow(book).to receive(:save).and_return(true)
    end

    it "assigns a new borrower" do
      borrower = Fabricate.build(:borrower)
      book.lend_to(borrower, 4)
      expect(book.borrower).to eq(borrower)
    end

    it "sets a reminder date" do
      allow(Time).to receive(:current).and_return(Time.current)
      borrower = Fabricate.build(:borrower)
      date = 4
      book.lend_to(borrower, date)
      expect(book.reminder_date).to eq(date.weeks.from_now)
    end

    it "sets lent date to today" do
      today = DateTime.now
      allow(DateTime).to receive(:now).and_return(today)
      borrower = Fabricate.build(:borrower)
      book.lend_to(borrower, 4)
      expect(book.lent_date).to eq(today)
      book.lend_to(borrower, "4")
      expect(book.lent_date).to eq(today)
    end
  end

  describe "#returned" do

    before do
      allow(book).to receive(:save).and_return(true)
      book.returned
    end

    it "clears the borrower" do
      expect(book.borrower).to eq(nil)
    end

    it "clears the reminder date" do
      expect(book.reminder_date).to eq(nil)
    end

    it "clears the lent date" do
      expect(book.lent_date).to eq(nil)
    end
  end
end
