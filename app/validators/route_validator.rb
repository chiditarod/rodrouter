class RouteValidator < ActiveModel::Validator
  def validate(record)
    validate_stop_count(record)
  end

  def validate_stop_count(record)
    if record.race.present? && record.leg_ids.present?
      ap record.race
      if record.leg_ids.size != record.race.num_stops + 2
        record.errors[:leg_ids] << "does not equal #{record.race.num_stops} stops + 1)"
      end
    end
  end
end
