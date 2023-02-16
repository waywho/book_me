class AppointmentType < ApplicationRecord
  # Associations
  belongs_to :user
  has_and_belongs_to_many :calendars
  has_many :events, dependent: :nullify
  has_many :appointments, dependent: :nullify

  # Validations
  validate :user_limits, on: :create
  validates :title, presence: true
  validates :duration, numericality: true, presence: true

  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :user

  after_initialize :generate_identifier

  def template_info
    {
      summary: "#{title}: FixR #{I18n.t(".shared.availability_slot")}",
      description: availability_identifier
    }
  end

  private

  def user_limits
    return if user.nil? || user.premium?

    errors.add(:base, :exceed_allowed_number) if user.appointment_types.size >= 1
  end

  def generate_identifier
    return self.availability_identifier if persisted? && self.availability_identifier.present?

    gen = Spicy::Proton.new

    self.availability_identifier =
      [:verb, :adverb, :adjective, :noun].sample(3).collect do |word_type|
        gen.send(word_type)
      end.join("_").camelcase
  end
end
