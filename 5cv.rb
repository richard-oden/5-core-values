class String
  def numeric?
    Float(self) != nil rescue false
  end
end

class Array
  def average
    inject(&:+) / size
  end
end

class Core_Value
  @@day = 1
  def initialize(name, day_rating, total_rating)
    @name = name
    @day_rating = day_rating
    @total_rating = total_rating
  end

  def rate(n)
    day_rating << n
    total_rating << n
  end
end

@fivecv = {
  purpose: [],
  autonomy: [],
  diligence: [],
  rationality: [],
  loved: []
}

questions = [
  "I have prioritized social interactions to the extent that I can handle them.",
  "I have practiced self compassion and approached flaws with wise mind, working towards a more positive view",
  "I have made new friends and stayed in touch with friends and family.",
  "I have maintained an average of 7 hrs of intentional free time a day.",
  "I am both independent and dependent.",
  "I have set aside time to pursue intrinsic interests.",
  "I have maintained consistency in efforts towards my goals.",
  "I have approached failure with the beginner's mind.",
  "I haven't changed my goals out of boredom, frustration, or dissapointment.",
  "Instead of avoiding emotions, I've viewed emotion in the context of reason.",
  "I have practied meditation and approached everything with a standpoint of mindfulness.",
  "I remembered that thoughts are not reality.",
  "I have acted with the long-term future in mind.",
  "I have asked myself why before acting.",
  "I have acted in the moment, taking small steps everyday towards my goals."
]

def enter_rating(cv)
  do_break = false
  loop do
    print "\n#{cv.to_s}: "
    input = gets.chomp
    if input.numeric?
      if (0..100).include?(input.to_i)
        puts "You entered #{input}. Is that correct? (Y/N)"
        loop do
          yn = gets.chomp
          if yn.downcase == "y"
            @fivecv[cv] << input.to_i
            puts "Rating confirmed. Your rating for #{cv} is #{input.to_i}."
            do_break = true
            break
          elsif yn.downcase == "n"
            puts "Rating cancelled. Please enter a number from 0-100."
            break
          else
            puts "'#{yn}' was not a valid answer. Please enter Y for yes or N for no."
          end
        end
      else
          puts "Input '#{input}' was not between 0 and 100! Please enter a number from 0-100."
      end
    else
        puts "Input '#{input}' was not a number! Please enter a number from 0-100. "
    end
    break if do_break
  end
end


puts "Welcome to the core value tracker.\nThis program serves as a way to monitor how well you are adhering to your core values."
days = [] #keeps track of ratings for each day
day = 0 #keeps track of day's number
loop do
  day += 1
  time = Time.new
  #User enters preliminary ratings for each core value and program displays them:
  puts "\nToday is day #{day}, #{time.month}/#{time.day}/#{time.year}. On a scale from 0-100, rate how well you are adhering to each value when prompted."
  @fivecv.each {|cv, r| enter_rating(cv)}
  puts "\nYour ratings for each core value are as follows:"
  @fivecv.each {|cv, r| puts "#{cv}: #{r}"}

  #User answers three additional questions for each core value:
  puts "\nNow that we have established a baseline for each of your core values, please rate how much you agree with each of the following statements on a scale from 0-100."
  questions.each do |q|
    loop do
      puts q
      q_input = gets.chomp
      if q_input.numeric?
        if (0..100).include?(q_input.to_i)
          puts "You entered #{q_input}.\n"
          case questions.index(q)
          when 0..2 then @fivecv[:loved] << q_input.to_i
          when 3..5 then @fivecv[:autonomy] << q_input.to_i
          when 6..8 then @fivecv[:diligence] << q_input.to_i
          when 9..11 then @fivecv[:rationality] << q_input.to_i
          when 12..14 then @fivecv[:purpose] << q_input.to_i
          end
          break
        else
          puts "Input '#{q_input}' was not between 0 and 100! Please enter a number from 0-100."
        end
      else
          puts "Input '#{q_input}' was not a number! Please enter a number from 0-100."
        end
      end
    end



  #Program prints average ratings for each core value:
  puts "\nYour total rating for each core value is as follows:"
  @fivecv.each {|cv, r| puts "#{cv}: #{r.average}"}

  #Program prompts user to continue on to next day.
  puts "Continue on to the next day? (Y/N)"
  loop do
    c_yn = gets.chomp
    if c_yn.downcase == "y"
      break
    elsif c_yn.downcase == "n"
      loop do
        puts "What would you like to do?\n(1) Change an entry for today.\n(2) Delete today's entries and enter them again.\n(3) Erase all entries and start over.\n(4) Return to previous menu."
        c_input = gets.chomp
        case c_input.to_i
        when 1

        when 2

        when 3

        when 4 then break
        else
          puts "#{c_input} was not a valid entry. Please enter 1, 2, 3, 4."
        end
      end
    else
      puts "'#{c_yn}' was not a valid answer. Please enter Y for yes or N for no."
    end
  end
end
