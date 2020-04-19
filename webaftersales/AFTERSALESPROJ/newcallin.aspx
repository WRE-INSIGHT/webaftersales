<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="newcallin.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.newcallin" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>manage call-in</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="page-header">
        <h3><strong>Manage call-in</strong></h3>
        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/CallinPage.aspx" runat="server">back</asp:LinkButton>
        <div class="navbar-right">
            <asp:TextBox ID="cin" CssClass="form-control" placeholder="CIN" runat="server"></asp:TextBox>
        </div>
    </div>

    <div class="panel-group">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <asp:HyperLink ID="HyperLink1" runat="server" data-toggle="collapse" href="#collapse1"><span class="glyphicon glyphicon-resize-vertical"></span>&nbsp;Select project</asp:HyperLink>
                </h4>
            </div>
            <div id="collapse1" class="panel-collapse collapse">
                <div class="panel-body">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="input-group">
                                <asp:TextBox ID="keytbox" CssClass="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="LinkButton2" OnClick="LinkButton2click" CssClass="btn btn-primary" runat="server">Find</asp:LinkButton>
                                </div>
                            </div>
                            <asp:GridView ID="GridView1" GridLines="None" AutoGenerateColumns="false" CssClass="table" AllowPaging="true" PageSize="10" runat="server"
                                OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="panel">
                                                <asp:Button ID="bindProject" CommandName="myselect" Font-Size="Large" CssClass="btn btn-default" runat="server" Text='<%# Eval("PROJECT") %>' /><br />
                                                <blockquote>
                                                    <asp:Label ID="bindAddress" Font-Size="Small" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label><br />
                                                    <asp:Label ID="bindJo" Font-Size="Medium" runat="server" Text='<%# Bind("JO") %>'></asp:Label><br />
                                                </blockquote>
                                            </div>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerSettings PageButtonCount="8" />
                                <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#CCCCFF" Font-Bold="True" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="panel-footer">Footer</div>
            </div>
        </div>
    </div>
    <br />
    <div class="form-group">

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                Project Details:<br />
                <br />
                <asp:TextBox ID="projectname" CssClass="form-control" placeholder="Project Name" runat="server" Enabled="False"></asp:TextBox>
                <br />
                <asp:TextBox ID="address" CssClass="form-control" placeholder="Address" runat="server" Enabled="False"></asp:TextBox>
                <br />
                <asp:TextBox ID="jo" CssClass="form-control" placeholder="Job order number" runat="server" Enabled="False"></asp:TextBox>
                <br />
                <asp:LinkButton ID="LinkButton3" CssClass="btn btn-default" runat="server" OnClick="LinkButton3_Click">clear project</asp:LinkButton>
                <br />
                <div class="row">
                    <div class="col-sm-4">
                        <br />
                        Date<br />
                        <asp:TextBox ID="calldate" CssClass="form-control" placeholder="Date" runat="server"></asp:TextBox>
                        <br />
                        Caller<br />
                        <asp:TextBox ID="callername" CssClass="form-control" placeholder="Caller" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-sm-4">
                        <br />
                        Telephone number<br />
                        <asp:TextBox ID="telno" CssClass="form-control" placeholder="Telephone number" runat="server"></asp:TextBox>
                        <br />
                        Fax number<br />
                        <asp:TextBox ID="faxno" CssClass="form-control" placeholder="Fax number" runat="server" OnTextChanged="faxno_TextChanged"></asp:TextBox>
                    </div>
                    <div class="col-sm-4">
                        <br />
                        Concern<br />
                        <asp:CheckBoxList ID="CheckBoxList1" runat="server">
                            <asp:ListItem Value="Window"> Window </asp:ListItem>
                            <asp:ListItem Value="Screen"> Screen </asp:ListItem>
                            <asp:ListItem Value="Mechanism"> Mechanism </asp:ListItem>
                            <asp:ListItem Value="Door"> Door </asp:ListItem>
                            <asp:ListItem Value="Glass"> Glass </asp:ListItem>
                            <asp:ListItem Value="Not specified"> Not specified </asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                </div>

                <br />
                <br />
                Conversation:<br />
                <asp:TextBox ID="conversation" CssClass="form-control" placeholder="Conversation" runat="server" Rows="10" TextMode="MultiLine"></asp:TextBox>
                <br />
                <asp:Button ID="Button1" ValidationGroup="val1" runat="server" CssClass="btn btn-primary" Text="Button" OnClick="Button1_Click" />
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="val1" CssClass="alert alert-danger" runat="server" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="date is required" ValidationGroup="val1" ControlToValidate="calldate"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="calldate" Operator="DataTypeCheck" ValidationGroup="val1" Type="Date" ErrorMessage="invalid call-in date"></asp:CompareValidator>
            </ContentTemplate>
        </asp:UpdatePanel>


    </div>

</asp:Content>
