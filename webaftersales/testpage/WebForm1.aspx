<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="webaftersales.testpage.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Scripts/bootstrap.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/bootstrap.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">WebSiteName</a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Home</a></li>
                        <li><a href="#">Page 1</a></li>
                        <li><a href="#">Page 2</a></li>
                        <li><a href="#">Page 3</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#"><span class="glyphicon glyphicon-user"></span>Sign Up</a></li>
                        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span>Login</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <%--  <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">WebSiteName</a>
                </div>
                <ul class="nav navbar-nav">
                    <li class="active"><a href="#">Home</a></li>
                    <li><a href="#">Page 1</a></li>
                    <li><a href="#">Page 2</a></li>
                    <li><a href="#">Page 3</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <asp:LinkButton ID="acctlink" runat="server">acctlink</asp:LinkButton></li>
                    <li>
                        <asp:LinkButton ID="LinkButton1" runat="server">Logout</asp:LinkButton></li>
                </ul>
            </div>
        </nav>--%>
        <div class="container">
            <div class="input-group">
                <input type="text" class="form-control" size="100" placeholder="Search" name="search">
                <div class="input-group-btn">
                    <button class="btn btn-default" type="submit">
                        <i class="glyphicon glyphicon-search"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="jumbotron">
                <h1>Bootstrap Tutorial</h1>
                <p>Bootstrap is the most popular HTML, CSS, and JS framework for developing responsive, mobile-first projects on the web.</p>
            </div>
        </div>
        <div class="container">
            <div class="page-header">
                <h1>Example Page Header</h1>
            </div>
            <p>This is some text.</p>
            <p>This is another text.</p>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <h1>Blockquotes</h1>
                    <p>The blockquote element is used to present content from another source:</p>
                    <blockquote class="blockquote-reverse">
                        <p>For 50 years, WWF has been protecting the future of nature. The world's leading conservation organization, WWF works in 100 countries and is supported by 1.2 million members in the United States and close to 5 million globally.</p>
                        <footer>From WWF's website</footer>
                    </blockquote>
                </div>
                <div class="col-sm-4">
                    <h1>Blockquotes</h1>
                    <p>The blockquote element is used to present content from another source:</p>
                    <blockquote>
                        <p>For 50 years, WWF has been protecting the future of nature. The world's leading conservation organization, WWF works in 100 countries and is supported by 1.2 million members in the United States and close to 5 million globally.</p>
                        <footer>From WWF's website</footer>
                    </blockquote>
                </div>
                <div class="col-sm-4">
                    <h1>Blockquotes</h1>
                    <p>The blockquote element is used to present content from another source:</p>
                    <blockquote>
                        <p>For 50 years, WWF has been protecting the future of nature. The world's leading conservation organization, WWF works in 100 countries and is supported by 1.2 million members in the United States and close to 5 million globally.</p>
                        <footer>From WWF's website</footer>
                    </blockquote>
                </div>
            </div>
        </div>
        <div class="container">
            <h2>Striped Rows</h2>
            <p>The .table-striped class adds zebra-stripes to a table:</p>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Firstname</th>
                        <th>Lastname</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>John</td>
                        <td>Doe</td>
                        <td>john@example.com</td>
                    </tr>
                    <tr>
                        <td>Mary</td>
                        <td>Moe</td>
                        <td>mary@example.com</td>
                    </tr>
                    <tr>
                        <td>July</td>
                        <td>Dooley</td>
                        <td>july@example.com</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="container">
            <h2>Well Size</h2>
            <div class="well well-sm">Small Well</div>
            <div class="well">Normal Well</div>
            <div class="well well-lg">Large Well</div>
        </div>
        <div class="container">
            <div class="alert alert-success">
                <strong>Success!</strong> Indicates a successful or positive action.
            </div>

            <div class="alert alert-info">
                <strong>Info!</strong> Indicates a neutral informative change or action.
            </div>

            <div class="alert alert-warning">
                <strong>Warning!</strong> Indicates a warning that might need attention.
            </div>

            <div class="alert alert-danger">
                <strong>Danger!</strong> Indicates a dangerous or potentially negative action.
            </div>
        </div>

        <div class="container">
            <button type="button" class="btn">Basic</button>
            <button type="button" class="btn btn-default">Default</button>
            <button type="button" class="btn btn-primary">Primary</button>
            <button type="button" class="btn btn-success">Success</button>
            <button type="button" class="btn btn-info">Info</button>
            <button type="button" class="btn btn-warning">Warning</button>
            <button type="button" class="btn btn-danger">Danger</button>
            <button type="button" class="btn btn-link">Link</button>
        </div>
        <div class="container">
            <h2>Button Sizes</h2>
            <button type="button" class="btn btn-primary btn-lg">Large</button>
            <button type="button" class="btn btn-primary">Normal</button>
            <button type="button" class="btn btn-primary btn-sm">Small</button>
            <button type="button" class="btn btn-primary btn-xs">XSmall</button>
        </div>
        <div class="container">
            <h2>Button Group</h2>
            <p>The .btn-group class creates a button group:</p>
            <div class="btn-group">
                <button type="button" class="btn btn-primary">Apple</button>
                <button type="button" class="btn btn-primary">Samsung</button>
                <button type="button" class="btn btn-primary">Sony</button>
            </div>
        </div>
        <div class="container">
            <div class="btn-group btn-group-lg">
                <button type="button" class="btn btn-primary">Apple</button>
                <button type="button" class="btn btn-primary">Samsung</button>
                <button type="button" class="btn btn-primary">Sony</button>
            </div>
        </div>
        <div class="container">
            <div class="btn-group-vertical">
                <button type="button" class="btn btn-primary">Apple</button>
                <button type="button" class="btn btn-primary">Samsung</button>
                <button type="button" class="btn btn-primary">Sony</button>
            </div>
        </div>
        <div class="container">
            <div class="btn-group btn-group-justified">
                <a href="#" class="btn btn-primary">Apple</a>
                <a href="#" class="btn btn-primary">Samsung</a>
                <a href="#" class="btn btn-primary">Sony</a>
            </div>
        </div>
        <div class="container">
            <h2>Justified Button Groups</h2>
            <div class="btn-group btn-group-justified">
                <div class="btn-group">
                    <button type="button" class="btn btn-primary">Apple</button>
                </div>
                <div class="btn-group">
                    <button type="button" class="btn btn-primary">Samsung</button>
                </div>
                <div class="btn-group">
                    <button type="button" class="btn btn-primary">Sony</button>
                </div>
            </div>
        </div>
        <div class="btn-group">
            <button type="button" class="btn btn-primary">Apple</button>
            <button type="button" class="btn btn-primary">Samsung</button>
            <div class="btn-group">
                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                    Sony <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li><a href="#">Tablet</a></li>
                    <li><a href="#">Smartphone</a></li>
                </ul>
            </div>
        </div>

        <p>Envelope icon: <span class="glyphicon glyphicon-envelope"></span></p>
        <p>
            Envelope icon as a link:
  <a href="#"><span class="glyphicon glyphicon-envelope"></span></a>
        </p>
        <p>Search icon: <span class="glyphicon glyphicon-search"></span></p>
        <p>
            Search icon on a button:
  <button type="button" class="btn btn-default">
      <span class="glyphicon glyphicon-search"></span>Search
  </button>
        </p>
        <p>
            Search icon on a styled button:
  <button type="button" class="btn btn-info">
      <span class="glyphicon glyphicon-search"></span>Search
  </button>
        </p>
        <p>Print icon: <span class="glyphicon glyphicon-print"></span></p>
        <p>
            Print icon on a styled link button:
  <a href="#" class="btn btn-success btn-lg">
      <span class="glyphicon glyphicon-print"></span>Print
  </a>
        </p>

        <div class="panel panel-default">
            <div class="panel-heading">Panel Heading</div>
            <div class="panel-body">Panel Content</div>
            <div class="panel-footer">Panel Footer</div>
        </div>
        <div class="container">
            <h2>Panels with Contextual Classes</h2>
            <div class="panel-group">
                <div class="panel panel-default">
                    <div class="panel-heading">Panel with panel-default class</div>
                    <div class="panel-body">Panel Content</div>
                </div>

                <div class="panel panel-primary">
                    <div class="panel-heading">Panel with panel-primary class</div>
                    <div class="panel-body">Panel Content</div>
                </div>

                <div class="panel panel-success">
                    <div class="panel-heading">Panel with panel-success class</div>
                    <div class="panel-body">Panel Content</div>
                </div>

                <div class="panel panel-info">
                    <div class="panel-heading">Panel with panel-info class</div>
                    <div class="panel-body">Panel Content</div>
                </div>

                <div class="panel panel-warning">
                    <div class="panel-heading">Panel with panel-warning class</div>
                    <div class="panel-body">Panel Content</div>
                </div>

                <div class="panel panel-danger">
                    <div class="panel-heading">Panel with panel-danger class</div>
                    <div class="panel-body">Panel Content</div>
                </div>
            </div>
        </div>
        <div class="dropdown">
            <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
                Dropdown Example
  <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="#">HTML</a></li>
                <li><a href="#">CSS</a></li>
                <li><a href="#">JavaScript</a></li>
            </ul>
        </div>
        <div class="container">
            <h2>Collapsible Panel</h2>
            <p>Click on the collapsible panel to open and close it.</p>
            <div class="panel-group">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" href="#collapse1">Collapsible panel</a>
                        </h4>
                    </div>
                    <div id="collapse1" class="panel-collapse collapse">
                        <div class="panel-body">Panel Body</div>
                        <div class="panel-footer">Panel Footer</div>
                    </div>
                </div>
            </div>
        </div>

        <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>

        <!-- Modal -->
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Modal Header</h4>
                    </div>
                    <div class="modal-body">
                        <p>Some text in the modal.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
