<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="quotation.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotation" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Quotation</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton3" CssClass="btn btn-default" runat="server" PostBackUrl="~/AFTERSALESPROJ/CallinPage.aspx">back</asp:LinkButton>
        </div>
    </div>
    <h2>
        <strong>
            <asp:Label ID="lblproject" runat="server" Text="Project Name"></asp:Label></strong><br />
        <small>
            <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label></small></h2>
    <br />
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


   


    <div class="panel panel-primary">
        <div class="panel-heading">
            Quotation List
        </div>
        <div class="panel-body">

            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="Panel2" ScrollBars="Horizontal" runat="server">
                        <asp:GridView ID="GridView1" GridLines="None" AutoGenerateColumns="false" runat="server" OnRowCommand="GridView1_RowCommand" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="panel panel-default">

                                            <div class="panel-body">
                                                <asp:Label ID="idlbl" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                                <asp:Label ID="asenolbl" Font-Size="XX-Large" runat="server" Text='<%# Bind("ASENO") %>'></asp:Label>
                                                <asp:LinkButton ID="LinkButton1" CommandName="myedit" runat="server">Edit</asp:LinkButton><br />
                                                <asp:Label ID="datelbl" Font-Size="Medium" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>


                                                <small>
                                                    <table class="table" border="1">
                                                        <tr>
                                                            <th>Status</th>
                                                            <th>Other Charger</th>
                                                            <th>Particular</th>
                                                            <th>Net price</th>
                                                            <th>Actual price</th>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="acceptedlbl" runat="server" Text='<%# Eval("ACCEPTED").ToString() == "" ? "Pending" : Eval("ACCEPTED") %>'></asp:Label></td>
                                                            <td>
                                                                <asp:Label ID="otherlbl" runat="server" Text='<%# Bind("[OTHER CHARGES]") %>'></asp:Label></td>
                                                            <td>
                                                                <asp:Label ID="particularlbl" runat="server" Text='<%# Bind("PARTICULAR") %>'></asp:Label></td>
                                                            <td>
                                                                <asp:Label ID="netpricelbl" runat="server" Text='<%# Bind("NETPRICE") %>'></asp:Label></td>
                                                            <td>
                                                                <asp:Label ID="actualpricelbl" runat="server" Text='<%# Bind("[ACTUAL PRICE]") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="5">
                                                                <asp:Button ID="items" CommandName="myitem" runat="server" CssClass="btn btn-default" Text="items" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </small>

                                                <asp:Panel ID="Panel1" Visible="false" runat="server">
                                                    <small>
                                                        <div class="panel panel-primary">
                                                            <div class="panel-body">
                                                                <div class="row">

                                                                    <div class="col-sm-4">
                                                                        ASE#<br />
                                                                        <asp:TextBox ID="editasenotbox" placeholder="ASE" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                                        Quotation date
                                                                <asp:RequiredFieldValidator ID="editRequiredFieldValidator1" runat="server" ErrorMessage="Date is required!"
                                                                    ControlToValidate="editdatetbox" ValidationGroup="editval" ForeColor="Red">*</asp:RequiredFieldValidator><br />
                                                                        <asp:TextBox ID="editdatetbox" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                                    </div>
                                                                    <div class="col-sm-4">
                                                                        Other charges<br />
                                                                        <asp:TextBox ID="editothertbox" placeholder="Other charges" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                                        Particular<br />
                                                                        <asp:TextBox ID="editparticulartbox" placeholder="Particular" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                                    </div>
                                                                    <div class="col-sm-4">
                                                                        Accepted date:<br />
                                                                        <asp:TextBox ID="editaccepteddatetbox" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                                        <asp:Button ID="Button2" runat="server" CommandName="mysave" ValidationGroup="editval" CssClass="btn btn-primary" Text="save" />
                                                                    </div>
                                                                </div>
                                                                <asp:ValidationSummary ID="editvalsummary" ValidationGroup="editval" CssClass="alert alert-danger" runat="server" />

                                                            </div>
                                                            <div class="panel-footer">
                                                                <asp:Button ID="Button3" runat="server" CommandName="mycancel" CssClass="btn btn-default" Text="cancel" />
                                                                <div class="navbar-right">
                                                                    <asp:LinkButton ID="LinkButton2" CommandName="mydelete" CssClass="btn btn-default" OnClientClick="return confirm('delete this record?')" runat="server"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </small>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle Wrap="False" />
                            <SelectedRowStyle BackColor="#CCCCFF" />
                            <PagerSettings PageButtonCount="8" />
                            <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                            <EmptyDataTemplate>
                                <div class="alert alert-danger">
                                    <h2><strong>Sorry, no data available!</strong>
                                        <small>0 result found</small>
                                    </h2>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <br />
     <div class="panel panel-default">
        <div class="panel-body">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-6">
                            Quotation date
                               <asp:CompareValidator ID="CompareValidator1" ControlToValidate="datetbox" Type="Date" Operator="DataTypeCheck"
                                   ValidationGroup="newval" runat="server" ErrorMessage="Invalid date format!" ForeColor="Red">*</asp:CompareValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Date is required!"
                                ControlToValidate="datetbox" ValidationGroup="newval" ForeColor="Red">*</asp:RequiredFieldValidator><br />
                            <asp:TextBox ID="datetbox" TextMode="Date" placeholder="Date" CssClass="form-control" runat="server"></asp:TextBox><br />
                            ASE#<br />
                            <asp:TextBox ID="asetbox" placeholder="ASE" CssClass="form-control" runat="server"></asp:TextBox><br />
                        </div>
                        <div class="col-sm-6">
                            Other charges<br />
                            <asp:TextBox ID="othertbox" placeholder="Other charges" CssClass="form-control" runat="server"></asp:TextBox><br />
                            Particular<br />
                            <asp:TextBox ID="particulartbox" placeholder="Particular" CssClass="form-control" runat="server"></asp:TextBox><br />
                        </div>

                    </div>



                    <asp:Button ID="newbtn" OnClick="newbtn_click" CssClass="btn btn-primary" ValidationGroup="newval" runat="server" Text="add" />
                    <asp:ValidationSummary ID="valsummary" ValidationGroup="newval" CssClass="alert alert-danger" runat="server" />

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
