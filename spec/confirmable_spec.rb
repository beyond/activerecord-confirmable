require 'spec_helper'

describe ActiveRecord::Confirmable do
	context "confirmed attribute is not set" do
		subject { Article.new }

		context "validation is fail" do
			it "should not be valid" do
				subject.should_not be_valid
				subject.save.should be_false
				subject.errors[ :confirmed ].should be_empty
			end
		end

		context "validation is success" do
			it "should be saved" do
				subject.title = "title"
				subject.should be_valid
				subject.save.should be_true
			end
		end
	end

	context "confirmed is blank string (new state)" do
		subject { Article.new confirmed: "" }

		context "validation is fail" do
			it "should not be in confirmation status yet" do
				subject.should_not be_valid
				subject.save.should be_false
				subject.errors[ :confirmed ].should be_empty
				subject.confirmation?.should be_false
			end
		end

		context "validation is success" do
			before do
				subject.title = "title"
			end

			it "should be in confirmation" do
				subject.should_not be_valid
				subject.save.should be_false
				subject.errors[ :confirmed ].should be_empty
				subject.confirmation?.should be_true
			end

			it "should be accepted" do
				subject.save
				subject.confirmed.should == "1"
			end
		end
	end

	context "confirmed is '1' string (prepare to submit)" do
		subject { Article.new confirmed: "1" }

		context "validation is fail" do
			it "should be required title" do
				subject.should_not be_valid
				subject.save.should be_false
				subject.errors[ :confirmed ].should be_empty
				subject.confirmation?.should be_false
			end
		end

		context "validation is success" do
			before do
				subject.title = "title"
			end

			it "shoud be submittable" do
				subject.should be_valid
				subject.save.should be_true
			end
		end
	end

	context "confirmed is false (back button from confimation)" do
		subject { Article.new confirmed: false }

		context "validation is fail" do
			it "should be new state" do
				subject.should_not be_valid
				subject.save.should be_false
				subject.errors[ :confirmed ].should be_empty
				subject.confirmation?.should be_false
			end
		end

		context "validation is success" do
			before do
				subject.title = "title"
			end

			it "should be new state" do
				subject.title = "title"
				subject.should_not be_valid
				subject.save.should be_false
				subject.confirmation?.should be_false
			end
		end
	end

	context "confirmed is 'false' string (back and submit)" do
		subject { Article.new confirmed: "false" }

		context "validation is fail" do
			it "should be new state" do
				subject.should_not be_valid
				subject.save.should be_false
				subject.errors[ :confirmed ].should be_empty
				subject.confirmation?.should be_false
			end
		end

		context "validation is success" do
			before do
				subject.title = "title"
			end

			it "should be submittable" do
				subject.should_not be_valid
				subject.save.should be_false
				subject.confirmation?.should be_true
			end

			it "should be accepted" do
				subject.save
				subject.confirmed.should == "1"
			end
		end
	end
end

