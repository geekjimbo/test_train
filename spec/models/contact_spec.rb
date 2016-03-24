require 'rails_helper'

describe Contact do
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: "Jimmy", 
      lastname: "Figueroa",
      email: "jimmyfigueroa@me.com"
    )
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact = Contact.new(firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid without a lastname"  do
    contact = Contact.new(lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it "is invalid without an email address"  do
    contact = Contact.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    Contact.create(firstname: "joe", lastname: "doe", email: "joe@doe.com")
    contact = Contact.new(firstname: "jean", lastname: "baptist", email: "joe@doe.com")
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it "returns a contact's full name as string" do 
    contact = Contact.new(
      firstname: "Jimmy", 
      lastname: "Figueroa",
      email: "jimmyfigueroa@me.com"
    )
    expect(contact.name).to eq("Jimmy Figueroa")
  end

  it "list contacts by 1st letter of the last name's search" do
    figueroa = Contact.create(
      firstname: "Jimmy", 
      lastname: "Figueroa",
      email: "jimmyfigueroa@me.com"
    )
    jones = Contact.create(
      firstname: "Tommy", 
      lastname: "Jones",
      email: "tommy@jones.com"
    )
    james = Contact.create(
      firstname: "Susan", 
      lastname: "James",
      email: "susan@james.com"
    )

    expect(Contact.by_letter("J")).to eq([james, jones])
  end
end
