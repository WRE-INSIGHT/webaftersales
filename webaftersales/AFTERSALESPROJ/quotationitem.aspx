<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="quotationitem.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationitem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation Items</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:scriptmanager runat="server"></asp:scriptmanager>
    <div class="well">
        <h3><strong>Quotation items</strong></h3>
        <div class="navbar-right">
            <asp:linkbutton id="LinkButton1" cssclass="btn btn-default" runat="server" postbackurl="~/AFTERSALESPROJ/quotation.aspx">back</asp:linkbutton>
        </div>
    </div>
    <h2>
        <strong>
            <asp:label id="lblproject" runat="server" text="Project Name"></asp:label>
        </strong>
        <br />
        <small>
            <asp:label id="lbladdress" runat="server" text="Address"></asp:label>
        </small></h2>
    <asp:label id="lblaseno" font-size="XX-Large" runat="server" text="Label"></asp:label>
    <br />
    <asp:validationsummary validationgroup="val1" cssclass="alert alert-danger" id="ValidationSummary1" runat="server" />
    <asp:updatepanel runat="server">
   <ContentTemplate>

  
    <div class="well">

        <div class="row">
            <div class="col-sm-4">
                Item #<br />
                <asp:textbox id="itemnotbox" cssclass="form-control" runat="server"></asp:textbox>
                <br />
            </div>
            <div class="col-sm-4">
                K #<br />
                <asp:textbox id="knotbox" cssclass="form-control" runat="server"></asp:textbox>
                <br />
            </div>
            <div class="col-sm-4">
                Location<br />
                <asp:textbox id="locationtbox" cssclass="form-control" runat="server"></asp:textbox>
                <br />
            </div>
        </div>
        <asp:button id="Button1" runat="server" text="add" cssclass="btn btn-primary" onclick="Button1_Click" />
           <asp:button id="Button3" runat="server" text="import" cssclass="btn btn-default" OnClick="Button3_Click"/>
    </div>

    <div class="panel panel-primary">

        <div class="panel-body">
            <asp:gridview id="GridView1" gridlines="None" autogeneratecolumns="false" runat="server" onrowcommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <asp:LinkButton ID="LinkButton2" ForeColor="Yellow" runat="server" CommandName="myedit">Edit</asp:LinkButton>
                                </div>
                                <div class="panel-body">
                                    <asp:Label ID="locationlbl" runat="server" Font-Size="X-Large" Text='<%# Bind("LOCATION") %>'></asp:Label>
                                    <asp:Label ID="idlbl" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>


                                    <br />
                                    <table class="table">
                                        <tr>
                                            <th>K #</th>
                                            <th>Item #</th>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="knolbl" runat="server" Text='<%# Bind("KNO") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="itemnolbl" runat="server" Text='<%# Bind("itemno") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <asp:Panel ID="Panel1" Visible="false" runat="server">
                                        <div class="panel panel-primary">
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        Item #<br />
                                                        <asp:TextBox ID="edititemnotbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                    </div>
                                                    <div class="col-sm-4">
                                                        K #<br />
                                                        <asp:TextBox ID="editknotbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                    </div>
                                                    <div class="col-sm-4">
                                                        Location<br />
                                                        <asp:TextBox ID="editlocationtbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                    </div>
                                                </div>
                                                <div class="panel">
                                                    <asp:Button ID="editbtn" runat="server" Text="save" CssClass="btn btn-primary" CommandName="mysave" />
                                                </div>
                                            </div>
                                            <div class="panel-footer">
                                                <asp:Button ID="Button2" runat="server" CommandName="myclose" CssClass="btn btn-default" Text="close" />
                                            </div>
                                        </div>
                                    </asp:Panel>

                                    <asp:GridView ID="GridView2" AutoGenerateColumns="false" ShowHeader="false" GridLines="None" DataSource='<%# Bind("thisparts") %>' runat="server" OnRowCommand="GridView2_RowCommand">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <asp:Label ID="partsidlbl" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                                            <asp:Label ID="Label2" Font-Size="Large" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label><br />
                                                            Article #:&nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Bind("ARTICLENO") %>'></asp:Label><br />
                                                            <asp:LinkButton runat="server" CommandName="g2myedit">Edit</asp:LinkButton>&nbsp;
                                                    <asp:LinkButton runat="server" CommandName="g2mydelete" OnClientClick="return confirm('delete this record?')">Delete</asp:LinkButton>
                                                            <table class="table" border="1">
                                                                <tr>
                                                                    <th><small>mark up</small> </th>
                                                                    <th><small>unit price</small> </th>
                                                                    <th><small>qty</small> </th>
                                                                    <th><small>net price</small> </th>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <small>
                                                                            <asp:Label ID="markuplbl" runat="server" Text='<%# Bind("MARKUP") %>'></asp:Label></small>
                                                                    </td>
                                                                    <td>
                                                                        <small>
                                                                            <asp:Label ID="unitpricelbl" runat="server" Text='<%# Bind("UNITPRICE") %>'></asp:Label></small>
                                                                    </td>
                                                                    <td>
                                                                        <small>
                                                                            <asp:Label ID="qtylbl" runat="server" Text='<%# Bind("QTY") %>'></asp:Label></small>
                                                                    </td>
                                                                    <td>
                                                                        <small>
                                                                            <asp:Label ID="netamountlbl" runat="server" Text='<%# Bind("netamount") %>'></asp:Label></small>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <asp:Panel ID="Panel2" Visible="false" runat="server">
                                                                <div class="well">
                                                                Mark up<br />
                                                                <asp:TextBox ID="markuptbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                                Unit price<br />
                                                                <asp:TextBox ID="unitpricetbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                                Qty<br />
                                                                <asp:TextBox ID="qtytbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                                Net amount<br />
                                                                <asp:TextBox ID="netamounttbox" CssClass="form-control" Enabled="false" runat="server"></asp:TextBox><br />
                                                                    <asp:Button runat="server" CssClass="btn btn-primary" CommandName="g2mysave" Text="save"></asp:Button>&nbsp;       
                                                                              <asp:Button runat="server" CssClass="btn btn-default" CommandName="g2myclose" Text="close"></asp:Button>
                                                                    </div>
                                                            </asp:Panel>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div class="panel-footer">
                                    <asp:LinkButton ID="LinkButton4" CssClass="btn btn-default" runat="server" CommandName="parts">parts</asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton3" CssClass="btn btn-danger" runat="server" OnClientClick="return confirm('delete this record?')" CommandName="mydelete"><span class="glyphicon glyphicon-trash">&nbsp;Delete</span></asp:LinkButton>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:gridview>

        </div>
    </div>
        </ContentTemplate>
    </asp:updatepanel>
</asp:Content>
