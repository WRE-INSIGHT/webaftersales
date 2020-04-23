<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="assessmentPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.assessmentPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Assessment</title>
    <style>
        .table00.v1 td {
            font-size: 13px;
        }

        .table00.v1 th {
        }

        .table00.v1 {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0px 40px 0px rgba(0, 0, 0, 0.15);
            -moz-box-shadow: 0 0px 40px 0px rgba(0, 0, 0, 0.15);
            -webkit-box-shadow: 0 0px 40px 0px rgba(0, 0, 0, 0.15);
            -o-box-shadow: 0 0px 40px 0px rgba(0, 0, 0, 0.15);
            -ms-box-shadow: 0 0px 40px 0px rgba(0, 0, 0, 0.15);
        }

            .table00.v1 footer {
                padding: 0px;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="well">
            <h2>
                <asp:Label ID="lblkno" runat="server" Text="Label"></asp:Label><small>
                    <asp:Label ID="lbllocation" runat="server" Text="Label"></asp:Label></small></h2>
            <div class="navbar-right">
                <asp:HyperLink ID="HyperLink1" CssClass="btn btn-default" NavigateUrl="~/AFTERSALESPROJ/reportPage.aspx" runat="server" Text="back"></asp:HyperLink>
            </div>
        </div>
    </div>
    <div class="container">
        <br />


        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="well">
                    <h4>Cutting List</h4>
                    <div class=" input-group">
                        <asp:TextBox ID="findtbox" Height="40" CssClass="form-control" runat="server"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:Button ID="Button1" runat="server" Height="40" OnClick="findbtn_Click" CssClass="btn btn-primary" Text="Find" />
                        </div>
                    </div>
                </div>

                <br />
                <asp:GridView ID="GridView1" CssClass="table table-striped" GridLines="None" runat="server"
                    AutoGenerateColumns="False" EmptyDataText="No result found."
                    AllowPaging="True" DataKeyNames="ID"
                    OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="5" OnRowDataBound="GridView1_RowDataBound" ShowFooter="True">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="cboxselect" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label ID="Label1" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("STOCKNO") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:LinkButton ID="LinkButton1" CLASS="btn btn-default" OnClick="importbtn_Click" runat="server">import</asp:LinkButton>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="HEADER" DataField="HEADER" />
                        <asp:BoundField HeaderText="COSTHEAD" DataField="COSTHEAD" />
                        <asp:BoundField HeaderText="COLOR" DataField="TYPECOLOR" />
                        <asp:BoundField HeaderText="ARTICLE#" DataField="ARTICLENO" />
                        <asp:BoundField HeaderText="DESCRIPTION" DataField="DESCRIPTION" />


                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                    <RowStyle Font-Names="Segoe UI" Font-Size="10pt" Height="35px" />
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Sorry, no data available!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>

            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <%--    <asp:Button ID="importbtn" CssClass="btn btn-default" runat="server" Text="Import selected items" OnClick="importbtn_Click" />--%>

                <div class="well">
                    <h3><string>Assessment</string></h3>
                </div>


                <asp:GridView ID="GridView2" CssClass="table00 v1 table" GridLines="None" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1" OnPageIndexChanging="GridView2_PageIndexChanging" OnRowDataBound="GridView2_RowDataBound" CellPadding="4" ForeColor="#333333" PageSize="5">

                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />

                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:TemplateField HeaderText="" SortExpression="">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Visible="false" Text='<%# Eval("ID") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="" SortExpression="">
                            <EditItemTemplate>
                                <asp:Label ID="Label4" runat="server" Visible="false" Text='<%# Bind("REPORTID") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Visible="false" Text='<%# Bind("REPORTID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="STOCKNO" SortExpression="STOCKNO">
                            <EditItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("STOCKNO") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("STOCKNO") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DESCRIPTION" SortExpression="DESCRIPTION">
                            <EditItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ASSESSMENT" SortExpression="ASSESSMENT">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" CssClass="form-control" TextMode="MultiLine" Rows="10" runat="server" Text='<%# Bind("ASSESSMENT") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("ASSESSMENT") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>


                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#F7F6F3" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Sorry, no data available!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>"
                    DeleteCommand="DELETE FROM [TBLassessment] WHERE [ID] = @ID"
                    InsertCommand="
                        declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from tblassessment)
                        INSERT INTO [TBLassessment] ([ID], [REPORTID], [STOCKNO], [DESCRIPTION], [ASSESSMENT]) VALUES (@ID, @REPORTID, @STOCKNO, @DESCRIPTION, @ASSESSMENT)"
                    SelectCommand="SELECT * FROM [TBLassessment] WHERE ([REPORTID] = @REPORTID)"
                    UpdateCommand="UPDATE [TBLassessment] SET [REPORTID] = @REPORTID, [STOCKNO] = @STOCKNO, [DESCRIPTION] = @DESCRIPTION, [ASSESSMENT] = @ASSESSMENT WHERE [ID] = @ID">
                    <DeleteParameters>
                        <asp:Parameter Name="ID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>

                        <asp:Parameter Name="REPORTID" Type="Int32" />
                        <asp:Parameter Name="STOCKNO" Type="Int32" />
                        <asp:Parameter Name="DESCRIPTION" Type="String" />
                        <asp:Parameter Name="ASSESSMENT" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="REPORTID" SessionField="reportID" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="REPORTID" Type="Int32" />
                        <asp:Parameter Name="STOCKNO" Type="Int32" />
                        <asp:Parameter Name="DESCRIPTION" Type="String" />
                        <asp:Parameter Name="ASSESSMENT" Type="String" />
                        <asp:Parameter Name="ID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>


            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="navbar-right">
            <asp:HyperLink ID="HyperLink2" runat="server" class="btn btn-success" data-toggle="modal" data-target="#myModal">new</asp:HyperLink>
        </div>


        <!-- Modal -->
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">NEW ITEM</h4>
                    </div>
                    <div class="modal-body">
                        <div class=" form-group">
                            <asp:TextBox ID="descriptiontbox" placeholder="Description" Height="40" CssClass="form-control" runat="server"></asp:TextBox><br />
                            <asp:TextBox ID="assessmenttbox" placeholder="Assessment" Rows="10" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:LinkButton ID="LinkButton2" runat="server" OnClick="addnew" CssClass="btn btn-success"><span class="glyphicon glyphicon-save"></span>Add</asp:LinkButton>
                        <button type="button" class="btn btn-default btn-danger pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span>Close</button>
                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
