from docutils import nodes
from docutils.parsers.rst import Directive
import os.path

try:
    from urllib.parse import urlencode
except ImportError:
    from urllib import urlencode


class github(nodes.General, nodes.Element):
    pass


class GithubDirective(Directive):
    has_content = True
    required_arguments = 1
    optional_arguments = 0
    final_argument_whitespace = False

    def run(self):
        env = self.state.document.settings.env
        base_url = env.config.github_base_url
        return [github(label=self.arguments[0], base_url=base_url)]


def html_visit_github_node(self, node):
    if self.builder.name == 'epub':
        raise nodes.SkipNode
    label = node['label']
    base_url = node['base_url']
    aname = ''
    if node.parent.hasattr('ids') and node.parent['ids']:
        aname = node.parent['ids'][0]
    docname = self.builder.current_docname
    view_url = '%s/issues?labels=%s&page=1&state=open' % (base_url, label)
    source_url = '%s/blob/master/docs/%s.rst' % (base_url, docname)
    edit_url = '%s/edit/master/docs/%s.rst' % (base_url, docname)
    back_link = 'back-link: %s.html#%s' % (docname, aname)
    query = urlencode({'labels': label, 'body': back_link})
    create_url = '%s/issues/new?%s' % (base_url, query)
    self.body.append('<p><div class="btn-group btn-group-justified" role="group">')
    self.body.append('<a class="btn btn-primary btn-xs" href="%s" target="_blank">Github</a>' % base_url)
    self.body.append('<a class="btn btn-primary btn-xs" href="%s" target="_blank"><i class="glyphicon glyphicon-file"></i> View</a>' % source_url)
    self.body.append('<a class="btn btn-primary btn-xs" href="%s" target="_blank"><i class="glyphicon glyphicon-pencil"></i> Edit</a>' % edit_url)
    self.body.append('<a class="btn btn-primary btn-xs" href="%s" target="_blank"><i class="glyphicon glyphicon-plus"></i> Issue </a>' % create_url)
    self.body.append('<a  class="btn btn-primary btn-xs" href="%s" target="_blank"><i class="glyphicon glyphicon-search"></i> Issues</a>' % view_url)
    self.body.append('</div></p>')


def html_depart_github_node(self, node):
    pass


def latex_visit_github_node(self, node):
    raise nodes.SkipNode


def epub_visit_github_node(self, node):
    raise nodes.SkipNode


def setup(app):
    app.add_node(
        github,
        html=(html_visit_github_node, html_depart_github_node),
        latex=(latex_visit_github_node, None),
        epub=(epub_visit_github_node, None)
        )
    app.add_config_value('github_base_url', None, 'env')
    app.add_directive("github", GithubDirective)
