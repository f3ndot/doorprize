module ApplicationHelper

  def legitimacy_score_popover_text
    "<p><strong>Doored.ca</strong> is a <em>crowdsourced</em> stats database with all of its data entered by users. As a result, many reports could be fraudulent or misrepresented.</p><p>A <strong>legitimacy or reliability score</strong> exists to automatically determine which data points are most likely to be accurate.</p><p>An admin or moderator, at a later time, may manually verify the details of a report and set a score override.</p>".html_safe
  end
end
