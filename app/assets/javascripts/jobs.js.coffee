$ ->
  $jobsList = $('#jobsList')

  console.debug("HELLO")

  if $jobsList.length > 0
    $.get 'https://jobs.rubyparis.org/en/job_offers.json', (jobs) ->
      job_links = $.map jobs, (job) ->
        if job.company_logo.favicon.url
          img = "<img class=\"logo-jobs\" src=\"#{job.company_logo.favicon.url}\" /><p>(#{job.company_name})</p>"
        else
          img = "<h2>#{job.company_name}</h2>"
        """
          <div class="job col-sm-4">
            <div class="boxes-job">
              <a class="job-link" href="https://jobs.rubyparis.org/en/job_offers/#{job.slug}">
                <p>#{img}</p>
                <p><strong>#{job.title}</strong></p>
              </a>
            </div>
          </div>
        """
      $jobsList.append(job_links.join(''))
