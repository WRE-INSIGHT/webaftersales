<%@ Page Language="C#" MasterPageFile="~/DAILYHEALTHPROFILE/DHPmaster.Master" AutoEventWireup="true" CodeBehind="dhpnew.aspx.cs" Inherits="webaftersales.DAILYHEALTHPROFILE.dhpnew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>NEW DHP</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>NEW DHP</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/DAILYHEALTHPROFILE/dhphome.aspx" runat="server">back</asp:LinkButton>
        </div>
    </div>

    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <br />
    <div class="row">
        <div class="col-6-sm">
        </div>
        <div class="col-6-sm">
        </div>
    </div>
    <div class="panel">
         <h3 class="text-info">EMPLOYEE DAILY HEALTH PROFILE</h3>
       <h4>RECORD DATE: <asp:Label ID="lbldate" runat="server" Text="Label"></asp:Label></h4> 
                            <blockquote>
                              <h4><table border="0">

                                    <tr>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td class="text-muted">NAME
                                        </td>
                                        <td>
                                            <asp:Label ID="lblname" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">EMPLOYEE NO.
                                        </td>
                                        <td>
                                            <asp:Label ID="lblempno" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">BIRTHDATE
                                        </td>
                                        <td>
                                            <asp:Label ID="lblbirthday" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">AGE
                                        </td>
                                        <td>
                                            <asp:Label ID="lblage" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                </table></h4>  
                            </blockquote>
        <br />
        <h4 class="text-info"><strong>Body Temperature Records for the day:</strong> </h4>
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
            <table class="table" border="1" style="white-space: nowrap;">
                <tr>
                    <th>Time of Day
                    </th>
                    <th>Actual Time Taken
                    </th>
                    <th>Temperature Reading (˚C)
                    </th>
                </tr>
                <tr>
                    <td>Morning (upon arrival at work)</td>
                    <td>
                        <asp:TextBox ID="tboxmoatt" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxmotr" CssClass="form-control" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Midday (while at work)</td>
                    <td>
                        <asp:TextBox ID="tboxmiatt" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxmitr" CssClass="form-control" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Afternoon (while at work)</td>
                    <td>
                        <asp:TextBox ID="tboxafatt" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxaftr" CssClass="form-control" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Afternoon / Evening (before leaving work)</td>
                    <td>
                        <asp:TextBox ID="tboxevatt" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxevtr" CssClass="form-control" runat="server"></asp:TextBox></td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <h4>Possible COVID 19 signs/symptoms experienced in the last 24 hours. Indicate date and estimated time only if answer to any of the symptoms is Yes:  
        </h4>
        <div class="text-info">(Mga posibleng senyales o sintomas na naranasan sa nakaraang 24 oras. )</div>
        <br />
        <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">
            <table border="1" style="white-space: nowrap;" class="table table-striped table-dark text-center">
                <tr>
                    <td>
                        <strong>SIGN/SYMPTOM</strong>
                        <br />
                        <small class="text-danger">(Senyales/Sintomas)</small>
                    </td>
                    <td>
                        <strong>Experienced</strong>
                        <br />
                        <small class="text-danger">(Naranasan)</small><br />
                        YES | NO
                    </td>
                    <td>
                        <strong>Date of Onset</strong>
                        <br />
                        <small class="text-danger">(mm/dd/yy</small>
                    </td>
                    <td>
                        <strong>Estimated Time
                            <br />
                            of Onset</strong>
                        <br />
                        <small class="text-danger">(H:M)</small>
                    </td>
                    <td style="width: 350px; min-width: 350px;">
                        <strong>REMARKS</strong>
                        <br />
                        <small class="text-danger">(Paglalahad)</small>
                    </td>
                </tr>
                <tr>
                    <td><strong>DRY COUGH</strong><br />
                        <small class="text-danger">(tuyo o matigas na ubo)</small>
                    </td>
                    <td>
                        <asp:RadioButton CssClass="btn btn-default" GroupName="DCEX" ID="DCEXyes" runat="server" />&nbsp;&nbsp;<asp:RadioButton CssClass="btn btn-default" GroupName="DCEX" ID="DCEXno" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxDCDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDCET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDCRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                <tr>
                    <td><strong>FEVER</strong><br />
                        <small class="text-danger">(lagnat – 37.5˚ o higit pa ↑)</small>
                    </td>
                    <td>
                        <asp:RadioButton CssClass="btn btn-default" GroupName="FEEX" ID="FEEXyes" runat="server" />&nbsp;&nbsp;<asp:RadioButton CssClass="btn btn-default" GroupName="FEEX" ID="FEEXno" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="tboxFEDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxFEET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxFERE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                <tr>
                    <td><strong>MUSCLE PAIN</strong><br />
                        <small class="text-danger">(pananakit ng kalamnan)</small>
                    </td>
                    <td>
                        <asp:RadioButton CssClass="btn btn-default" GroupName="MPEX" ID="MPEXyes" runat="server" />&nbsp;&nbsp;<asp:RadioButton CssClass="btn btn-default" GroupName="MPEX" ID="MPEXno" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxMPDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxMPET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxMPRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                <tr>
                    <td><strong>WEAKNESS</strong><br />
                        <small class="text-danger">((panghihina))</small>
                    </td>
                    <td>
                        <asp:RadioButton CssClass="btn btn-default" GroupName="WEEX" ID="WEEXyes" runat="server" />&nbsp;&nbsp;<asp:RadioButton CssClass="btn btn-default" GroupName="WEEX" ID="WEEXno" runat="server" /></td>
                    <td>
                        <asp:TextBox ID="tboxWEDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxWEET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxWERE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                <tr>
                    <td><strong>DECREASED SENSE<br />
                        OF SMELL</strong><br />
                        <small class="text-danger">(kawalan ng pang-amoy)</small>
                    </td>
                    <td>
                        <asp:RadioButton CssClass="btn btn-default" GroupName="DSEX" ID="DSEXyes" runat="server" />&nbsp;&nbsp;<asp:RadioButton CssClass="btn btn-default" GroupName="DSEX" ID="DSEXno" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="tboxDSDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDSET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDSRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                <tr>
                    <td><strong>DECREASED SENSE<br />
                        OF TASTE</strong><br />
                        <small class="text-danger">(kawalan ng panlasa)</small>
                    </td>
                    <td>
                        <asp:RadioButton CssClass="btn btn-default" GroupName="DTEX" ID="DTEXyes" runat="server" />&nbsp;&nbsp;<asp:RadioButton CssClass="btn btn-default" GroupName="DTEX" ID="DTEXno" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="tboxDTDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDTET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDTRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                <tr>
                    <td><strong>DIARRHEA</strong><br />
                        <small class="text-danger">(pagtatae)</small>
                    </td>
                    <td>
                        <asp:RadioButton CssClass="btn btn-default" GroupName="DIEX" ID="DIEXyes" runat="server" />&nbsp;&nbsp;<asp:RadioButton CssClass="btn btn-default" GroupName="DIEX" ID="DIEXno" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="tboxDIDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDIET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDIRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                <tr>
                    <td><strong>DIFFICULTY OF<br />
                        BREATHING</strong><br />
                        <small class="text-danger">(hirap na paghinga)</small>
                    </td>
                    <td>
                        <asp:RadioButton CssClass="btn btn-default" GroupName="DBEX" ID="DBEXyes" runat="server" />&nbsp;&nbsp;<asp:RadioButton CssClass="btn btn-default" GroupName="DBEX" ID="DBEXno" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="tboxDBDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDBET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxDBRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                <tr>
                    <td><strong>LOOSE BOWEL
                        <br />
                        MOVEMENT</strong><br />
                        <small class="text-danger">()</small>
                    </td>
                    <td>
                        <asp:RadioButton CssClass="btn btn-default" GroupName="LBEX" ID="LBEXyes" runat="server" />&nbsp;&nbsp;<asp:RadioButton CssClass="btn btn-default" GroupName="LBEX" ID="LBEXno" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="tboxLBDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxLBET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxLBRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
                <tr>
                    <td><strong>OTHER SYMPTOM(s)</strong><br />
                        <asp:TextBox ID="tboxOS" CssClass="form-control" runat="server"></asp:TextBox>
                        <small class="text-danger">(Iba pang kakaibang
                            <br />
                            karamdaman)</small>
                    </td>
                    <td>
                        <asp:RadioButton CssClass="btn btn-default" GroupName="OSEX" ID="OSEXyes" runat="server" />&nbsp;&nbsp;<asp:RadioButton CssClass="btn btn-default" GroupName="OSEX" ID="OSEXno" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="tboxOSDO" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxOSET" CssClass="form-control" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="tboxOSRE" CssClass="form-control" runat="server"></asp:TextBox></td>

                </tr>
            </table>

        </asp:Panel>
        <div class="text-center">
            <strong>NOTE/OBSERVATIONS</strong>
            <br />
            <small class="text-info">(Nurse’s comments)</small><br />
            <asp:TextBox ID="tboxCOM" runat="server" TextMode="MultiLine" Rows="10" CssClass="form-control"></asp:TextBox>
        </div>
        <asp:Button ID="Button2" CssClass="btn btn-primary" runat="server" Text="save" OnClick="Button2_Click" />
    </div>
</asp:Content>
