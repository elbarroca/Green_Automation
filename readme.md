# Git-Automation: The ASCII Art Commits Project 🎨

Welcome to **Git-Automation**! 🎉 This project is here to poke a little fun at the whole "green square" contribution culture on GitHub and fill your profile with some cool ASCII art while we’re at it. You know, those green squares everyone loves to have filled? Well, let’s be real—just because we’re committing every day doesn’t mean it’s “meaningful work.” Sometimes, it’s just fun! So why not do something different with it?

---

## ✨ What’s This All About?

This project automatically commits updates to an ASCII art file daily, gradually building up different pieces of art in your repository over time. Each day, a new line from an ASCII art image is added to a file, and by the end of the process, you get a full piece of ASCII art committed to your GitHub profile. When one image is done, we move on to the next. It’s like a slow reveal, pixel by pixel… but with characters!

In the end, it doesn’t *really* mean much, but it’s a fun way to make your profile come alive with little daily updates. If people check out your contributions, they’ll see some cool ASCII art forming over time. Who says commits need to be serious?

---

## 🌟 Why Did I Do This?

Let’s be honest: a lot of people judge profiles by those green squares. But does daily committing really say much about skill, contribution, or dedication? Not really. So here’s a playful way to fill those squares without pretending it’s all about productivity. 😜

This is a reminder that not every commit is “meaningful” and that sometimes, the commitment to the *art* of coding (or ASCII) is worth just as much as a line of functional code. It’s a little personal protest and a bit of fun.

---

## 🤔 How It Works

Here’s the rundown of what’s happening:

1. **ASCII Art Files**: We have a set of ASCII art images saved as text files in the `ascii_images/` folder. Each file has one line of ASCII art per line in the text file.
2. **Daily Commit Magic**: A script runs daily, taking one line from the current ASCII art file and appending it to `output.txt`.
3. **10 Daily Commits**: To maximize the green squares, the script commits 10 times each day. Slowly but surely, it builds up each piece of ASCII art in `output.txt`.
4. **Moving to the Next Image**: When one image is complete, the script moves to the next file, revealing the next image one line at a time.

### Structure

- **`ascii_images/`**: This folder contains each ASCII image as a text file (like `image1.txt`, `image2.txt`, etc.).
- **`output.txt`**: The file where each line of ASCII art is slowly revealed each day.
- **`progress.txt`**: Tracks which image and line we’re currently on. It’s our little progress marker.
- **`daily_update.sh`**: The magic script that does the work every day, adding a line, committing it, and keeping track of progress.

---

## 🚀 Setup Instructions

1. **Clone the Repo**: Clone this repository to your local machine.
2. **Configure Git**: Set up your Git username, email, and a GitHub Personal Access Token.
3. **Automate the Script**:
   - For local automation, set up a cron job.
   - For GitHub automation, configure GitHub Actions using the included `daily_commit.yml` file.
4. **Watch the Art Grow**: Sit back and watch as each ASCII art image builds up day by day, filling your contribution graph with unique updates!

---

## ⚙️ Customization

Feel free to add your own ASCII images to the `ascii_images/` folder. Just keep each ASCII image in its own file and split it by lines—one line per row. The script will take care of the rest. And if you want to tweak how often it commits, adjust the cron job or GitHub Actions settings to your preference.

---

## 📅 Why This Matters (or Doesn’t)

This project exists because, honestly, green squares don’t tell the whole story. Committing every day doesn’t necessarily mean you’re more productive or a better developer. Sometimes, we just like seeing a fully filled contribution graph—it’s visually satisfying, and that’s okay! Think of this project as a small reminder that while it’s cool to show off your GitHub activity, what matters most is the quality and passion behind your work, not the number of commits.

---

## ✌️ License

This project is open-source under the MIT license. Feel free to fork, customize, and make it your own!

---

Enjoy the ASCII art, and may your profile stay green (even if it doesn’t mean anything)! 😎
