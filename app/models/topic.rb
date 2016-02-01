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

  def generate_posts(entry, n)
    puts "in generate posts.."
    comments_doc = Nokogiri::HTML(open(entry.css('ul.flat-list.buttons li.first a')[0]["href"]))
    comments = comments_doc.css(".commentarea form div.md p:first-child")

    j = [n, comments.length].min
    comments[0, j].each do |comment|
      body = comment.text
      user_id = (self.posts.length == 0)? self.user.id : User.random_id


      post = self.posts.new(user_id: user_id, topic_id: self.id, body: body )

      if post.valid?
        post.save
      end
    end
  end

  def self.determine_forum_from(subject)
    puts "In forum team.."
    forums = { 'The ACC' => ["Boston College", "Clemson", "Duke", "Florida State",
      "Georgia Tech", "Louisville", "Miami", "North Carolina", "NC State", "Notre Dame",
      "Pittsburgh", "Syracuse", "Virginia", "Virginia Teach", "Wake Forest"],
               'The Big Ten' => ["Indiana", "Maryland", "Michigan State", "Michigan", "Ohio State",
      "Penn State", "Rutgers", "Illinois", "Iowa", "Minnesota", "Nebraska", "Northwestern",
      "Purdue", "Wisconsin"],
              'The Big 12' => ["Baylor", "Iowa State", "Kansas", "KSU", "Oklahoma",
      "Oklahoma State", "Texas", "TCU", "Texas Tech", "West Virginia"],
              'The SEC' => ["Alabama", "Arkansas", "Auburn", "Georgia", "LSU", "Kentucky",
      "Vanderbilt", "South Carolina", "Missouri", "Texas A&M", "Florida", "Tennessee", "Ole Miss",
      "Mississippi State"],
              'The PAC 12' => ["Arizona", "ASU", "UC Berkley", "Colorado", "Oregon", "Oregon State",
      "USC", "Stanford", "Utah", "Washington", "WSU"]
    }

    forums.keys.each do |forum|
      forums[forum].each do |team|
        return forum if subject.match(/(#{team})/)
      end
    end

    nil
  end

  def self.generate
    doc = Nokogiri::HTML(open("https://www.reddit.com/r/cfb"))
    # Nokogiri::XML::NodeSet
    entries = doc.css("div#siteTable div.entry.unvoted")
    # n is desired amount of entries
    n = 16
    i = [n, entries.length].min
    entries[0, i].each do |entry|

      subject = entry.css('p.title a[tabindex="1"]').inner_html
      forum_name = Topic.determine_forum_from(subject)
      if forum_name

        forum = Forum.find_by_name(forum_name)
        user_id = User.random_id
        topic = Topic.new(forum_id: forum.id, user_id: user_id, subject: subject)
        if topic.valid?

          topic.save
          topic.generate_posts(entry, rand(6...12))
        end
      end
    end
  end

  private

  def to_s
    return "Topic"
  end
end
