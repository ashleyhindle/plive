# Plive


## TODO
- [ ] v0.1: Create: a poll with a question, exactly 2 answers, random colors
- [ ] v0.1: Create: live preview
- [ ] v0.1: Answer: poll, show answers as big buttons, click on one, show results
- [ ] v0.2: Create: x answers
- [ ] v0.3: Create: subtitle, select colors
- [ ] v0.4: Answer: Live avatars like heeds
- [ ] Fix: poll on_replace: :delete - why can't it be update? It's just a waste to have 2 deletes, then 2 inserts when updating a poll?! 5? queries for 1 update to a 3 form field?!


### Poll Thinking
- Question
- Subtitle
- Visualisation type (only support bar to start)
- Options, min: 1
  - color (for bar/pie/donut)
  - answer
