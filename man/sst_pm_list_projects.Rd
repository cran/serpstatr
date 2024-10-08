% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/project_management.R
\name{sst_pm_list_projects}
\alias{sst_pm_list_projects}
\title{List existing projects}
\usage{
sst_pm_list_projects(api_token, page = 1, size = 100, return_method = "list")
}
\arguments{
\item{api_token}{(required) Serpstat API token from
\href{https://serpstat.com/users/profile/}{your profile}.}

\item{page}{(optional) Response page number if there are many pages in response.}

\item{size}{(optional) Response page size.}

\item{return_method}{(optional) Accepted values are 'list' (default) to
return data object as list or 'df' to return data object as data.frame.}
}
\value{
Returns basic information on all the projects.
}
\description{
Gets a list of existing projects available for the users with their basic
information.
}
\section{API docs}{

 Check all the values for request and response fields \href{https://serpstat.com/api/get-list-of-projects/}{here}.
}

\section{API credits consumption}{
 0.
}

\examples{
\dontrun{
api_token <- Sys.getenv('SERPSTAT_API_TOKEN')
sst_pm_list_projects(
  api_token  = api_token,
  page       = 2,
  size       = 10
  )
}
}
