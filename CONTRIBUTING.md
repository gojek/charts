# GO-JEK Charts  - Contributing

Charts `github.com/gojektech/charts` is an open-source project, which is a collection of Kubernetes [Helm Charts][1]
It is licensed using the [Apache License 2.0][2]. 
We appreciate pull requests; here are our guidelines:

1.  [File an issue][3] 
    (if there isn't one already). If your patch
    is going to be large it might be a good idea to get the
    discussion started early.  We are happy to discuss it in a
    new issue beforehand, and you can always email
    <foss+charts@go-jek.com> about future work.

2.  Please refer to the technical requirements of a Helm Chart [Kubernetes Official Tech Requirements][4].

3.  We ask that you squash all the commits together before
    pushing and that your commit message references the bug.

## Issue Reporting
- Check that the issue has not already been reported.
- Be clear, concise and precise in your description of the problem.
- Open an issue with a descriptive title and a summary in grammatically correct,
  complete sentences.
- Include any relevant code to the issue summary.

## Pull Requests
- Please read this [how to GitHub][5] blog post.
- Use a topic branch to easily amend a pull request later, if necessary.
- Write [good commit messages][6].
- Use the same coding conventions as the rest of the project.
- Open a [pull request][7] that relates to *only* one subject with a clear title
  and description in grammatically correct, complete sentences.
- Run build.sh to update index.yaml for the updated chart.

Much Thanks! ❤❤❤

GO-JEK Tech

[1]: https://helm.sh/
[2]: http://www.apache.org/licenses/LICENSE-2.0
[3]: https://github.com/gojektech/charts/issues
[4]: https://github.com/kubernetes/charts/blob/master/CONTRIBUTING.md#technical-requirements
[5]: http://gun.io/blog/how-to-github-fork-branch-and-pull-request
[6]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[7]: https://help.github.com/articles/using-pull-requests
