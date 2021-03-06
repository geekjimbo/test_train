require 'rails_helper'

describe Contact do
  it "has a valid factory" do
    expect(build(:contact)).to be_valid
  end

  it "has three phone numbers" do 
    expect(create(:contact).phones.count).to eq 3
  end

  it "is invalid without a firstname" do
    contact = build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid without a lastname"  do
    contact = build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it "is invalid without an email address"  do
    contact = build(:contact, email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    create(:contact, email: "joe@doe.com")
    contact = build(:contact, email: "joe@doe.com")
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it "returns a contact's full name as string" do 
    contact = build(
      :contact,
      firstname: "Jimmy", 
      lastname: "Figueroa"
    )
    expect(contact.name).to eq("Jimmy Figueroa")
  end

  describe "filter last name by letter" do
    before :each do
      @figueroa = create(
        :contact,
        firstname: "Jimmy", 
        lastname: "Figueroa",
        email: "jimmyfigueroa@me.com"
      )
      @jones = create(
        :contact,
        firstname: "Tommy", 
        lastname: "Jones",
        email: "tommy@jones.com"
      )
      @james = create(
        :contact,
        firstname: "Susan", 
        lastname: "James",
        email: "susan@james.com"
      )
    end

    context "matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@james, @jones]
      end
    end

    context "non-matching letters" do
      it "omits results that do not match" do
        expect(Contact.by_letter("J")).not_to include @figueroa
      end
    end
  end
end
