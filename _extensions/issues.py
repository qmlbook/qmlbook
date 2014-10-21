from docutils import nodes
from sphinx.util.compat import Directive
import urllib

class issues(nodes.General, nodes.Element):
    pass

class IssuesDirective(Directive):
    has_content = True
    required_arguments = 1
    optional_arguments = 0
    final_argument_whitespace = False

    def run(self):
        env = self.state.document.settings.env
        base_url = env.config.issues_base_url
        return [issues(label=self.arguments[0], base_url = base_url)]

def html_visit_issues_node(self, node):
    if self.builder.name == 'epub':
        raise nodes.SkipNode
    label = node['label']
    base_url = node['base_url']
    aname = ''
    if node.parent.hasattr('ids') and node.parent['ids']:
        aname = node.parent['ids'][0]
    target = self.builder.get_target_uri(self.builder.current_docname)
    back_link = 'back-link: %s#%s'%(target, aname)
    query = urllib.urlencode({'labels': label, 'body':back_link})
    create_url = '%s/new?%s'%(base_url, query)
    view_url = '%s?labels=%s&page=1&state=open'%(base_url, label)
    self.body.append('<div class="admonition issues">')
    self.body.append('Issues: <a href="%s">Create</a>'%create_url)
    self.body.append(' | <a href="%s">View</a>'%view_url)
    self.body.append('</div>')

def html_depart_issues_node(self, node):
    pass

def latex_visit_issues_node(self, node):
    raise nodes.SkipNode

def epub_visit_issues_node(self, node):
    raise nodes.SkipNode

def setup(app):
    app.add_node(issues, 
        html=(html_visit_issues_node, html_depart_issues_node),
        latex=(latex_visit_issues_node, None),
        epub=(epub_visit_issues_node, None)
        )
    app.add_config_value('issues_base_url', None, 'env')
    app.add_directive("issues", IssuesDirective)