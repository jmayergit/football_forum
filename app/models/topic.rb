class Topic < ActiveRecord::Base
  require 'nokogiri'
  require 'open-uri'

  belongs_to :forum
  belongs_to :user
  has_many :posts, dependent: :destroy, validate: false

  accepts_nested_attributes_for :posts

  validates :subject, presence: true, uniqueness: true
  validates :forum_id, association: true
  validates :user_id, association: true

  self.per_page = 5

  def self.search(search)
    if search
      where("subject ~* ?", search)
    else
      all
    end
  end

  def self.forum_team(subject)
    puts "In forum team.."
    forums = { 'The ACC' => ["Boston College", "Clemson", "Duke", "Florida State",
      "Georgia Tech", "Louisville", "Miami", "North Carolina", "NC State", "Notre Dame",
      "Pittsburgh", "Syracuse", "Virginia", "Virginia Teach", "Wake Forest"],
               'The Big Ten' => ["Indiana", "Maryland", "Michigan State", "Michigan", "Ohio State",
      "Penn State", "Rutgers", "Illinois", "Iowa", "Minnesota", "Nebraska", "Northwestern",
      "Purdue", "Wisconsin"]}

    forums.keys.each do |forum|
      forums[forum].each do |team|
        return [forum, team] if subject.match(/(#{team})/)
      end
    end

    nil
  end

  def self.generate
    puts "starting generate.."
    doc = Nokogiri::HTML(open("https://www.reddit.com/r/cfb"))
    # Nokogiri::XML::NodeSet
    entries = doc.css("div#siteTable div.entry.unvoted")
    # n is desired amount of entries
    n = 8
    i = [n, entries.length].min
    entries[0, i].each do |entry|
      puts "In entries loop"
      subject = entry.css('p.title a[tabindex="1"]').inner_html
      puts "Subject is " + subject.to_s
      match = Topic.forum_team(subject)
      if match
        puts "Inside match"
        forum = Forum.find_by_name(match[0])
        puts "Forum is " + forum.name
        user = User.first
        puts "User is " + user.username
        topic = Topic.new(forum_id: forum.id, user_id: user.id, subject: subject)
        if topic.valid?
          topic.save
        end
      end
    end
  end

  private

  def to_s
    return "Topic"
  end
end
