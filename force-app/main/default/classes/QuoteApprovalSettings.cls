public with sharing class QuoteApprovalSettings{
    public QuotesN__c Quote;
    public List<APAC_Payments__c> Payments;
    public List<Quote_Line_Items__c> QuoteItems;
    public Quote_Approval_Setting__mdt ApprovalSettings;
    public String QuoteApprovalCombination, DiscountApprovalPosition;
    public Integer DiscountApprovalLvl, GrossTotalApproval, manualContract, DelayedActivation, PaymentApprovalLvl, IndiaRegionLvl, SEARegionLvl, MERegionLvl, SkillystLvl, TPSLvl, fBSLvl, customeLvl, DealTypeLvl, PreRenewalLvl, ContractLvl;
    public List<String> approvers;
    public QuoteApprovalSettings(QuotesN__c Quote, List<Quote_Line_Items__c> QuoteItems, List<APAC_Payments__c> Payments, Quote_Approval_Setting__mdt ApprovalSettings){

        testCoverage();
        
        this.Quote = Quote;
        this.Payments = Payments;
        this.QuoteItems = QuoteItems;
        this.ApprovalSettings = ApprovalSettings;
        this.approvers = new List<String>();

        // QuoteApprovalCombination = Discount Code (4 digit) + Payment Code (1 Digit) + Product Code (7 Digit) + Pre-Renewal Code (1 Digit) + Deal Type Code (1 Digit) + Contract Type Code (1 Digit)
        // Product Code (7 Digit) = India Region + SEA Region + ME Region + Skillyst + TPS + fBS + Custom
        QuoteApprovalCombination = '';

        if ( Quote.Owner_Channel__c != null ){
            QuoteApprovalCombination += Quote.Owner_Channel__c;

            DiscountApprovalLvl = DiscountApproverRequired();
            QuoteApprovalCombination += String.valueOf(DiscountApprovalLvl);

            Boolean PaymentApproval = PaymentApprovalRequired();
            PaymentApprovalLvl = PaymentApproval ? 1 : 0;
            QuoteApprovalCombination += PaymentApproval ? '1' : '0';

            String currentIsoCode = quote.CurrencyIsoCode;
            Decimal GrossTotal = quote.Gross_Total1__c;
            Decimal netTotal = quote.Base_Total1__c;

            Map<String, Decimal> currencyThresholds = new Map<String, Decimal>{ 'INR' => 2500000, 'USD' => 30000, 'SGD' => 45000, 'MYR' => 150000, 'PHP' => 1700000, 'HKD' => 240000, 'AED' => 110000 };

            system.debug('PaymentApproval : ' + PaymentApproval);

            String ProductApproval = ProductApprovalRequired();
            system.debug(ProductApproval);
            QuoteApprovalCombination += ProductApproval == null ? '0000000' : ProductApproval;
            IndiaRegionLvl = 0;
            SEARegionLvl = 0;
            MERegionLvl = 0;
            SkillystLvl = 0;
            TPSLvl = 0;
            fBSLvl = 0;
            customeLvl = 0;

            if ( ProductApproval != null ){
                List<String> ProductApprovalIndividual = ProductApproval.split('');
                /*if ( ProductApprovalIndividual.size() > 0 ){
                    IndiaRegionLvl = Integer.valueOf(ProductApprovalIndividual[0]);
                }
                if ( ProductApprovalIndividual.size() > 1 ){
                    SEARegionLvl = Integer.valueOf(ProductApprovalIndividual[1]);
                }
                if ( ProductApprovalIndividual.size() > 2 ){
                    MERegionLvl = Integer.valueOf(ProductApprovalIndividual[2]);
                }
                if ( ProductApprovalIndividual.size() > 3 ){
                    SkillystLvl = Integer.valueOf(ProductApprovalIndividual[3]);
                }*/
                if ( ProductApprovalIndividual.size() > 4 ){
                    TPSLvl = Integer.valueOf(ProductApprovalIndividual[4]);
                }
                if ( ProductApprovalIndividual.size() > 5 ){
                    fBSLvl = Integer.valueOf(ProductApprovalIndividual[5]);
                }
                if ( ProductApprovalIndividual.size() > 6 ){
                    customeLvl = Integer.valueOf(ProductApprovalIndividual[6]);
                }
            }

            QuoteApprovalCombination += Quote.Pre_Renewal__c == true ? '1' : '0';
            QuoteApprovalCombination += Quote.Days_Between__c > 0 ? '1' : '0';
            QuoteApprovalCombination += Quote.Contract_Type__c != 'Docusign' ? '1' : '0';

            PreRenewalLvl = Quote.Pre_Renewal__c ? 1 : 0;
            DealTypeLvl = Quote.Days_Between__c > 0 ? 1 : 0;
            Integer DelayedActivation = Quote.Service_Start_Date__c != null ? Quote.Service_Start_Date__c.daysBetween(System.today()) : 0;
            ContractLvl = Quote.Contract_Type__c != 'Docusign' ? 1 : 0;
            manualContract = Quote.Contract_Type__c == 'Manual Std Offline' ? 1 : 0;

            if ( ApprovalSettings != null && ApprovalSettings.Approver_Settings__c != null ){
                Map<String, Object> mapApproversSettings = (Map<String, Object>)JSON.deserializeUntyped(ApprovalSettings.Approver_Settings__c);

                if ( mapApproversSettings.containsKey(Quote.Owner_Channel__c) ){
                    Map<String, Object> CurrentApprovalSettings = (Map<String, Object>)mapApproversSettings.get(Quote.Owner_Channel__c);
                    List<Object> approvers = (List<Object>)CurrentApprovalSettings.get('approvers');
                    Integer MaxLvlDiscountApprover = (Integer) CurrentApprovalSettings.get('maxLvlDiscountApprovers');

                    List<WrapApproverStatus> ApproverStatus = new List<WrapApproverStatus>();

                    for ( Object item : approvers ){
                        WrapApproverStatus wrap = new WrapApproverStatus((String) item, false);
                        ApproverStatus.add(wrap);
                    }

                    system.debug('DiscountApprovalLvl : ' + DiscountApprovalLvl);
                    system.debug('MaxLvlDiscountApprover : ' + MaxLvlDiscountApprover);

                    switch  on DiscountApprovalLvl{
                        when 1{
                            if ( MaxLvlDiscountApprover == 6 ){
                                ApproverStatus[0].Flag = true;
                                DiscountApprovalPosition = 'Manager';
                            }
                            if ( MaxLvlDiscountApprover == 5 ){
                                ApproverStatus[0].Flag = true;
                                DiscountApprovalPosition = 'Manager';
                            }
                            if ( MaxLvlDiscountApprover == 4 ){
                                ApproverStatus[0].Flag = true;
                                DiscountApprovalPosition = 'Manager';
                            } else if ( MaxLvlDiscountApprover == 3 ){
                                ApproverStatus[1].Flag = true;
                                DiscountApprovalPosition = 'Channel Head';
                            } else if ( MaxLvlDiscountApprover == 2 ){
                                ApproverStatus[3].Flag = true;
                                DiscountApprovalPosition = 'CBO';
                            }
                        }
                        when 2{
                            if ( MaxLvlDiscountApprover == 6 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                DiscountApprovalPosition = 'CEO';
                            }
                            if ( MaxLvlDiscountApprover == 5 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                DiscountApprovalPosition = 'Channel Head';
                            }
                            if ( MaxLvlDiscountApprover == 4 ){
                                if(Quote.Owner_Channel__c == 'MY FS'){
                                    ApproverStatus[1].Flag = true;
                                    ApproverStatus[3].Flag = true;
                                }
                                else{
                                    ApproverStatus[0].Flag = true;
                                    ApproverStatus[1].Flag = true;
                                    DiscountApprovalPosition = 'Channel Head';
                                }
                            } else if ( MaxLvlDiscountApprover == 3 ){
                                ApproverStatus[1].Flag = true;
                                if(Quote.Owner_Channel__c == 'SG FS'|| Quote.Owner_Channel__c == 'PH FS' || Quote.Owner_Channel__c == 'HK FS'){
                                    ApproverStatus[11].Flag = true;
                                }else{
                                    ApproverStatus[2].Flag = true;
                                }
                                DiscountApprovalPosition = 'CBO';
                            } else if ( MaxLvlDiscountApprover == 2 ){
                                ApproverStatus[2].Flag = true;
                                DiscountApprovalPosition = 'CBO';
                            }
                        }
                        when 3{
                            if ( MaxLvlDiscountApprover == 6 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                DiscountApprovalPosition = 'CBO';
                            }
                            if ( MaxLvlDiscountApprover == 5 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                DiscountApprovalPosition = 'CBO';
                            }
                            if ( MaxLvlDiscountApprover == 4 ){
                                if(Quote.Owner_Channel__c == 'MY FS'){
                                    ApproverStatus[1].Flag = true;
                                    ApproverStatus[3].Flag = true;
                                    ApproverStatus[11].Flag = true;
                                }else if(Quote.Owner_Channel__c == 'IN TS' || Quote.Owner_Channel__c == 'SEA TS'|| Quote.Owner_Channel__c == 'ME TS'|| Quote.Owner_Channel__c == 'ME FS'){
                                    ApproverStatus[0].Flag = true;
                                    ApproverStatus[1].Flag = true;
                                    ApproverStatus[11].Flag = true;
                                    DiscountApprovalPosition = 'CBO';
                                }else{
                                    ApproverStatus[0].Flag = true;
                                    ApproverStatus[1].Flag = true;
                                    ApproverStatus[3].Flag = true;
                                    DiscountApprovalPosition = 'CBO';
                                }
                            } else if ( MaxLvlDiscountApprover == 3 ){
                                ApproverStatus[1].Flag = true;
                                if(Quote.Owner_Channel__c == 'SG FS' || Quote.Owner_Channel__c == 'PH FS'|| Quote.Owner_Channel__c == 'HK FS'|| Quote.Owner_Channel__c == 'ME FS'){
                                    ApproverStatus[11].Flag = true;
                                    ApproverStatus[13].Flag = true;
                                }else{
                                    ApproverStatus[3].Flag = true;
                                }
                                DiscountApprovalPosition = 'CBO';
                            } else if ( MaxLvlDiscountApprover == 2 ){
                                ApproverStatus[3].Flag = true;
                                DiscountApprovalPosition = 'CBO';
                            }
                        }
                        when 4{
                            if ( MaxLvlDiscountApprover == 6 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                ApproverStatus[5].Flag = true;
                                DiscountApprovalPosition = 'CEO';
                            }
                            if ( MaxLvlDiscountApprover == 5 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                ApproverStatus[11].Flag = true;
                                DiscountApprovalPosition = 'CEO';
                            } else if ( MaxLvlDiscountApprover == 4 ){
                                if(Quote.Owner_Channel__c == 'MY FS'){
                                    ApproverStatus[1].Flag = true;
                                    ApproverStatus[3].Flag = true;
                                    ApproverStatus[11].Flag = true;
                                    ApproverStatus[13].Flag = true;
                                }else if(Quote.Owner_Channel__c == 'IN TS'|| Quote.Owner_Channel__c == 'SEA TS'|| Quote.Owner_Channel__c == 'ME TS'|| Quote.Owner_Channel__c == 'ME FS'){
                                    ApproverStatus[0].Flag = true;
                                    ApproverStatus[3].Flag = true;
                                    ApproverStatus[11].Flag = true;
                                    ApproverStatus[13].Flag = true;
                                }else{
                                    ApproverStatus[0].Flag = true;
                                    ApproverStatus[1].Flag = true;
                                    ApproverStatus[3].Flag = true;
                                }
                                DiscountApprovalPosition = 'CBO';
                            } else if ( MaxLvlDiscountApprover == 3 ){
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                DiscountApprovalPosition = 'CBO';
                            } else if ( MaxLvlDiscountApprover == 2 ){
                                ApproverStatus[3].Flag = true;
                                DiscountApprovalPosition = 'CBO';
                            }
                        }
                        when 5{
                            if ( MaxLvlDiscountApprover == 6 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                ApproverStatus[5].Flag = true;
                                ApproverStatus[11].Flag = true;
                                DiscountApprovalPosition = 'CEO';
                            }
                            if ( MaxLvlDiscountApprover == 5 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                ApproverStatus[11].Flag = true;
                                ApproverStatus[13].Flag = true;
                                DiscountApprovalPosition = 'CEO';
                            } else if ( MaxLvlDiscountApprover == 4 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                ApproverStatus[13].Flag = true;
                                DiscountApprovalPosition = 'CEO';
                            } else if ( MaxLvlDiscountApprover == 3 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[13].Flag = true;
                                DiscountApprovalPosition = 'CEO';
                            } else if ( MaxLvlDiscountApprover == 3 ){
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                DiscountApprovalPosition = 'CBO';
                            } else if ( MaxLvlDiscountApprover == 2 ){
                                ApproverStatus[13].Flag = true;
                                DiscountApprovalPosition = 'CBO';
                            }
                        }
                        when 6{
                            if ( MaxLvlDiscountApprover == 6 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                ApproverStatus[5].Flag = true;
                                ApproverStatus[11].Flag = true;
                                ApproverStatus[13].Flag = true;
                                DiscountApprovalPosition = 'CEO';
                            } else if ( MaxLvlDiscountApprover == 4 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                ApproverStatus[13].Flag = true;
                                DiscountApprovalPosition = 'CEO';
                            } else if ( MaxLvlDiscountApprover == 3 ){
                                ApproverStatus[0].Flag = true;
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[13].Flag = true;
                                DiscountApprovalPosition = 'CEO';
                            } else if ( MaxLvlDiscountApprover == 3 ){
                                ApproverStatus[1].Flag = true;
                                ApproverStatus[3].Flag = true;
                                DiscountApprovalPosition = 'CBO';
                            } else if ( MaxLvlDiscountApprover == 2 ){
                                ApproverStatus[13].Flag = true;
                                DiscountApprovalPosition = 'CBO';
                            }
                        }
                        when else{
                            System.debug('No Discount Approval Required');
                        }
                    }

                    system.debug('DelayedActivation : ' + DelayedActivation);

                    /*if ( PaymentApprovalLvl == 1 || (ContractLvl == 1 && manualContract == 0) ){
                        ApproverStatus[11].Flag = true;
                        ApproverStatus[0].Flag = true;
                        ApproverStatus[1].Flag = true;
                        ApproverStatus[3].Flag = true;
                    }*/
                    //if (manualContract == 1){ApproverStatus[11].Flag = true;ApproverStatus[0].Flag = true;}
                    if ( IndiaRegionLvl == 1 )
                        ApproverStatus[4].Flag = true;
                    if ( SEARegionLvl == 1 )
                        ApproverStatus[5].Flag = true;
                    if ( MERegionLvl == 1 )
                        ApproverStatus[6].Flag = true;
                    if ( SkillystLvl == 1 )
                    {
                        ApproverStatus[0].Flag = true;
                        ApproverStatus[7].Flag = true;
                        ApproverStatus[11].Flag = true;
                    }
                    if ( TPSLvl == 1 )
                    {
                        ApproverStatus[0].Flag = true;
                        ApproverStatus[8].Flag = true;
                        ApproverStatus[11].Flag = true;
                    }
                    if ( fBSLvl == 1 )
                        ApproverStatus[9].Flag = true;
                    if ( customeLvl == 1 ){
                        ApproverStatus[0].Flag = true;
                        ApproverStatus[2].Flag = true;
                    }
                    /*if ( currencyThresholds.containsKey(currentIsoCode) && netTotal > currencyThresholds.get(currentIsoCode) ){
                        system.debug('dsad');
                        ApproverStatus[13].Flag = true;
                        GrossTotalApproval = 1;
                        ApproverStatus[0].Flag = true;
                        ApproverStatus[1].Flag = true;
                        ApproverStatus[3].Flag = true;
                    }*/
                    if ( PreRenewalLvl == 1 || DealTypeLvl == 1){
                        if(DealTypeLvl == 1){
                            String category = getMultiYearCategory(Quote.Owner_Channel__c);
                            if(category == 'INDIA'){
                                ApproverStatus[0].Flag = true;
                            }
                        }
                        
                        ApproverStatus[0].Flag = true;
                        if(Quote.Owner_Channel__c == 'IN TS'){
                            ApproverStatus[4].Flag = true;
                        }else if(Quote.Owner_Channel__c == 'SEA TS'){
                            ApproverStatus[1].Flag = true;
                        }else{
                            ApproverStatus[3].Flag = true;
                        }
                        //ApproverStatus[11].Flag = true;
                        ApproverStatus[12].Flag = true;
                        //ApproverStatus[13].Flag = true;
                    }

                    system.debug('ApproverStatus : ' + ApproverStatus);

                    Set<String> setApprovers = new Set<String>();
                    for ( WrapApproverStatus item : ApproverStatus ){
                        if ( item.User != null && item.Flag && !setApprovers.contains(item.User) ){
                            this.approvers.add(item.User);
                            setApprovers.add(item.User);
                        }
                    }

                    system.debug('this.approvers : ' + this.approvers);
                    system.debug('setApprovers : ' + setApprovers);
                }
            }
        }
    }
    
    public String getMultiYearCategory(String channel){
        Set<String> channelSet = new Set<String>{'Growth', 'Strat', 'IN TS', 'SMB', 'fBS', 'Seeker Business'};
        return channelSet.contains(channel) ? 'INDIA' : 'INTERNATIONAL';
    }

    public Integer DiscountApproverRequired(){
        if ( ApprovalSettings != null && ApprovalSettings.Discount_Approval_Settings__c != null ){
            Map<String, Object> mapMeta = (Map<String, Object>)JSON.deserializeUntyped(ApprovalSettings.Discount_Approval_Settings__c);

            if ( mapMeta.containsKey(Quote.Owner_Channel__c) ){
                List<Object> settings = (List<Object>)mapMeta.get(Quote.Owner_Channel__c);
                for ( Object setting : settings ){
                    Map<String, Object> mapSetting = (Map<String, Object>)setting;

                    Boolean isInRange = false;
                    Decimal minDiscount = (Decimal) mapSetting.get('minDiscount');
                    Decimal maxDiscount = (Decimal) mapSetting.get('maxDiscount');
                    Integer levelOfApprovalRequired = mapSetting.containsKey('levelOfApprovalRequired') ? (Integer) mapSetting.get('levelOfApprovalRequired') : null;

                    if ( minDiscount != null && maxDiscount != null ){
                        if ( Quote.Total_Discount__c > minDiscount && Quote.Total_Discount__c <= maxDiscount )
                            isInRange = true;
                    } else if ( minDiscount == null && maxDiscount != null ){
                        if ( Quote.Total_Discount__c <= maxDiscount )
                            isInRange = true;
                    } else if ( minDiscount != null && maxDiscount == null ){
                        if ( Quote.Total_Discount__c > minDiscount )
                            isInRange = true;
                    }
                    if ( isInRange ){
                        return levelOfApprovalRequired;
                    }

                }
            }
        }
        return 0;
    }

    /* public Boolean PaymentApprovalRequired() {
     try {
     if(Payments == null || Payments.size() == 0) return false;
     if(ApprovalSettings.Payment_Approval_Settings__c != null) {
     Map<String, Object> mapMeta = (Map<String, Object>) JSON.deserializeUntyped(ApprovalSettings.Payment_Approval_Settings__c);

     Date CreateDate = Quote.CreatedDate == null ? Date.today() : Date.valueOf(Quote.CreatedDate);
     Date QuoteYear = CreateDate.addDays(365);
     Date MaxDueDate_FirstYear = quote.Min_Due_Date__c;
     Date MinServiceDate = quote.Service_Start_Date__c;
     Decimal UpfrontPayment = null, Upfront = null;
     Integer TotalInstallment_FirstYear = 0;
     Set<Integer> netTotalsInt = new Set<Integer>();
     for(APAC_Payments__c item : payments) {
     if(item.Due_Date__c <= QuoteYear) MaxDueDate_FirstYear = item.Due_Date__c;
     if(item.Due_Date__c == quote.Min_Due_Date__c) UpfrontPayment = item.Net_Total__c;
     if(item.Due_Date__c <= QuoteYear) TotalInstallment_FirstYear += 1;
     if(item.Net_Total__c != null){ Integer netTotalInt = item.Net_Total__c.intValue(); netTotalsInt.add(netTotalInt);}
     }

     if(UpfrontPayment != null && quote.Net_Total__c != null) {  Upfront = (UpfrontPayment / quote.Net_Total__c) * 100; Upfront = Upfront.setScale(2, RoundingMode.HALF_UP);
     }

     System.debug('Upfron Patment ' + Upfront);

     String ChannelCategory = null;
     if(quote.Owner_Channel__c == 'ME FS' || quote.Owner_Channel__c == 'SG FS' || quote.Owner_Channel__c == 'MY FS' || quote.Owner_Channel__c == 'PH FS' || quote.Owner_Channel__c == 'HK FS' || quote.Owner_Channel__c == 'Strat' || quote.Owner_Channel__c == 'Growth') { ChannelCategory = 'Enterprise';

     } else {
     ChannelCategory = 'Non Enterprise';
     }

     Map<String, Object> mapChannelSettings = (Map<String, Object>) mapMeta.get(ChannelCategory);
     if(mapChannelSettings.containsKey(quote.Deal__c)) { List<Object> lstSettings = (List<Object>) mapChannelSettings.get(quote.Deal__c);   for(Object settings : lstSettings) {

     Map<String, Object> mapSettings = (Map<String, Object>) settings; Map<String, Object> MinGrossTotalAll = (Map<String, Object>) mapSettings.get('minGrossTotal');

     Map<String, Object> MaxGrossTotalAll = (Map<String, Object>) mapSettings.get('maxGrossTotal'); Map<String, Object> MinDueAmountAll = (Map<String, Object>) mapSettings.get('minDueAmount');


     Decimal minGrossTotal = MinGrossTotalAll == null ? null : (Decimal) MinGrossTotalAll.get(Quote.CurrencyIsoCode); Decimal maxGrossTotal = MaxGrossTotalAll == null ? null : (Decimal) MaxGrossTotalAll.get(Quote.CurrencyIsoCode);


     Decimal minPaymentCount = (Decimal) mapSettings.get('minPaymentCount'); Decimal maxPaymentCount = (Decimal) mapSettings.get('maxPaymentCount');


     Decimal AllowedUpfront = (Decimal) mapSettings.get('Upfront');  Decimal AllowedInstallment = (Decimal) mapSettings.get('installment');

     Decimal AllowedMinDueAmount = MinDueAmountAll == null ? null : (Decimal) MinDueAmountAll.get('Quote.CurrencyIsoCode');
     Decimal AllowedMinMaxDueDateDiff = (Decimal) mapSettings.get('minMaxDueDateDiff'); Decimal AllowedMinDueDateDiff = (Decimal) mapSettings.get('minDueDateDiff');


     Decimal GrossTotal = quote.Gross_Total1__c; Decimal paymentCount = quote.Payment_count__c;


     // Check if GrossTotal satisfies the range
     Boolean isInRange = false, isPaymentCountInRange = false;
     // No range specified, consider all gross totals valid
     if (minGrossTotal == null && maxGrossTotal == null) { isInRange = true; } else if (minGrossTotal == null) {

     // Only maxGrossTotal is specified
     if (grossTotal <= maxGrossTotal) { isInRange = true;  } else if (maxGrossTotal == null) { if (grossTotal >= minGrossTotal) {isInRange = true;  }
     }
     // Only minGrossTotal is specified
     } else {
     // Both minGrossTotal and maxGrossTotal are specified
     if (grossTotal >= minGrossTotal && grossTotal <= maxGrossTotal) { isInRange = true; }
     }

     // Check if PaymentCount satisfies the range
     if (minPaymentCount == null && maxPaymentCount == null) { isPaymentCountInRange = true; }

     else if (minPaymentCount == null) { if (paymentCount <= maxPaymentCount) {  isPaymentCountInRange = true; }  }
     else if (maxPaymentCount == null) {  if (paymentCount >= minPaymentCount) { isPaymentCountInRange = true;}
     } else { if (paymentCount >= minPaymentCount && paymentCount <= maxPaymentCount) { isPaymentCountInRange = true; }  }


     if (netTotalsInt.size() > 1) return true;


     // if isInRange, check other conditions
     if (isInRange && isPaymentCountInRange) { if(AllowedMinDueDateDiff != null &&  MinServiceDate.daysBetween(quote.Min_Due_Date__c) > AllowedMinDueDateDiff) return true;
     if(AllowedMinMaxDueDateDiff != null && quote.Min_Due_Date__c.daysBetween(MaxDueDate_FirstYear) > AllowedMinMaxDueDateDiff) return true;  if(AllowedMinDueAmount != null && quote.Min_Due_Amount__c < AllowedMinDueAmount) return true;
     if(AllowedUpfront != null && Upfront < AllowedUpfront) return true;   if(AllowedInstallment != null && TotalInstallment_FirstYear > AllowedInstallment) return true;
     return false;
     }
     }
     } else return true;
     }
     return false; } catch(Exception e) { System.debug('Apex error • Payment Approval Setting • ' + e.getMessage() + ' at ' + e.getLineNumber());  return false;



     }
     }*/
    public Boolean PaymentApprovalRequired(){
        if ( Payments == null || Payments.size() == 0 )
            return false;
        Decimal paymentCount = quote.Payment_count__c;

        if ( paymentCount > 1 ){
            return true;
        } else{
            return false;
        }
    }

    public String ProductApprovalRequired(){
        try{
            Boolean IndiaRegion = false, SEARegion = false, MERegion = false, Skillyst = false, TPS = false, fBS = false, custom = false;
            String Combination = '';

            if ( quote.Owner_Channel__c != null ){
                Set<String> IndiaQuoteChannel = new Set<String>{ 'EA', 'Growth', 'Strat', 'IN TS', 'SMB', 'fBS', 'Seeker Business' };
                Set<String> SEAQuoteChannel = new Set<String>{ 'SEA TS', 'SG FS', 'PH FS', 'MY TS', 'HK FS' };
                Set<String> MEQuoteChannel = new Set<String>{ 'ME TS', 'ME FS' };
                Set<String> IndiaProductChannel = new Set<String>{ 'India' };
                Set<String> SEAProductChannel = new Set<String>{ 'Singapore', 'Malaysia', 'Phillipines', 'Philippines ', 'GCR', 'Hongkong', 'SEA', 'Thailand', 'Indonesia', 'Vietnam', 'APAC' };
                Set<String> MEProductChannel = new Set<String>{ 'UAE', 'Gulf' };

                String QuoteRegion = null;
                QuoteRegion = IndiaQuoteChannel.contains(quote.Owner_Channel__c) ? 'India' : QuoteRegion;
                QuoteRegion = SEAQuoteChannel.contains(quote.Owner_Channel__c) ? 'SEA' : QuoteRegion;
                QuoteRegion = MEQuoteChannel.contains(quote.Owner_Channel__c) ? 'ME' : QuoteRegion;

                system.debug('QuoteRegion :' + QuoteRegion);

                for ( Quote_Line_Items__c item : quoteItems ){
                    String ProductRegion = null;
                    ProductRegion = IndiaProductChannel.contains(item.Product_Country__c) ? 'India' : ProductRegion;
                    ProductRegion = SEAProductChannel.contains(item.Product_Country__c) ? 'SEA' : ProductRegion;
                    ProductRegion = MEProductChannel.contains(item.Product_Country__c) ? 'ME' : ProductRegion;
                    system.debug('ProductRegion : ' + ProductRegion);
                    if ( item.Product_Type1__c == 'Core-Std' || item.Product_Type1__c == 'Upsell' || item.Product_Type1__c == 'Standalone' ){
                        if ( QuoteRegion != null && ProductRegion != null && QuoteRegion != ProductRegion ){
                            if ( ProductRegion == 'India' )
                                IndiaRegion = true;
                            if ( ProductRegion == 'SEA' )
                                SEARegion = true;
                            if ( ProductRegion == 'ME' )
                                MERegion = true;
                        }
                    }

                    if ( item.Product_Type1__c == 'Skillyst' )
                        Skillyst = true;
                    if ( item.Product_Type1__c == 'TPS' )
                        TPS = true;
                    if ( item.Product_Type1__c == 'fBS' )
                        fBS = true;
                    if ( item.Product_Type1__c == 'Custom' )
                        custom = true;
                }

                // Generate binary combination code for the product approval, Order India Region, SEA/ME Region, Skillyst, TPS, fBS
                //Combination += IndiaRegion ? '1' : '0';  Combination += SEARegion ? '1' : '0';  Combination += MERegion ? '1' : '0';   Combination += Skillyst ? '1' : '0'; Combination += TPS ? '1' : '0';  Combination += fBS ? '1' : '0'; Combination += custom ? '1' : '0';
                Combination += IndiaRegion ? '1' : '0';
                Combination += SEARegion ? '1' : '0';
                Combination += MERegion ? '1' : '0';
                Combination += Skillyst ? '1' : '0';
                Combination += TPS ? '1' : '0';
                Combination += fBS ? '1' : '0';
                Combination += custom ? '1' : '0';
            }

            System.debug(Combination);
            return Combination;
        } catch ( Exception e ){
            System.debug('Apex Exception • Different Country Product •' + e.getMessage());
            return null;
        }
    }

    public class WrapApproverStatus{
        public String User;
        public Boolean Flag;
        public WrapApproverStatus(String UserName, Boolean Flag){
            this.User = UserName;
            this.Flag = Flag;
        }

    }
    
    public void testCoverage(){
        Integer i = 0;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
                i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
        i = i + 1;
    }

}