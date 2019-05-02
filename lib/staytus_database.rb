class StaytusDatabase
  # A ordered list of classes that are seeded before server initialization.
  PRIMORDIAL_SEEDABLE_CLASSES = %w[
    Service
    User
  ].freeze

  # An ordered list of classes that will complete the seeding, but occuring
  # after server initialization.
  OTHER_SEEDABLE_CLASSES = %w[
  ].freeze
  SEEDABLE_CLASSES = PRIMORDIAL_SEEDABLE_CLASSES + OTHER_SEEDABLE_CLASSES

  def self.seed(classes = nil, exclude_list = [])
    classes ||= SEEDABLE_CLASSES
    classes  -= exclude_list
    classes   = classes.collect(&:constantize)

    invalid = classes.reject { |c| c.respond_to?(:seed) }
    raise ArgumentError, "class(es) #{invalid.join(", ")} do not respond to seed" if invalid.any?

    seed_classes(classes)
  end

  def self.seed_classes(classes)
    classes.each do |c|
      c.seed
    end
  end
  private_class_method :seed_classes
end
