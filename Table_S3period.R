rm( list = ls() )	

# set working and output directories
wd = "/Users/martinbulla/Dropbox/Science/ms_published/Kubelka_et_al_rebuttal/Analyses/"
outdir = '/Users/martinbulla/Dropbox/Science/ms_published/Kubelka_et_al_rebuttal/Outputs/'
#wd = 'C:/Users/mbulla/Documents/Dropbox/Science/Projects/MS/Kubelka_et_al_rebuttal/Analyses/'
#outdir = 'C:/Users/mbulla/Documents/Dropbox/Science/Projects/MS/Kubelka_et_al_rebuttal/Outputs/'

# print figures in PNG or not
PNG = TRUE

# load packages, constants and data
source(paste(wd, 'Constants_Functions.R',sep=""))
source(paste(wd, 'Prepare_Data.R',sep="")) # generates 18 warnings, same way as Kubelke et al's script

# TABLE S3year - latitude
# DPR
	# simple 	
     m0 = lmer(log(DPR) ~ log( N_nests) +hemisphere+ period_orig+lat_abs + (1|site)+(1|species),  data = d)  
   
	# interaction linear
     m1 = lmer(log(DPR) ~ log( N_nests) + hemisphere*period_orig*lat_abs +(1|site)+(1|species),  data = d)
	
	# simple 3rd polynomial
    m4 = lmer(log(DPR) ~ log( N_nests) + period_orig+poly(Latitude,3) +(1|site)+(1|species),  data = d) 
	
	# interaction 3rd polynomial
    m5 = lmer(log(DPR) ~ log( N_nests) + period_orig*poly(Latitude,3) +(1|site)+(1|species),  data = d)
  
	# model assumptions
	m_ass(name = 'DPR_period+hem+abs(lat)', mo = m0, dat = d, fixed = c('N_nests', 'lat_abs'),categ = c('hemisphere', 'period_orig'), trans = c('log','none','none'), spatial = TRUE, temporal = TRUE, PNG = TRUE)
	m_ass(name = 'DPR_period-hem-abs(lat)', mo = m1, dat = d, fixed = c('N_nests', 'lat_abs'),categ = c('hemisphere', 'period_orig'), trans = c('log','none','none'), spatial = TRUE, temporal = TRUE, PNG = TRUE)
	m_ass(name = 'DPR_period+poly3(lat)', mo = m4, dat = d, fixed = c('N_nests','Latitude'),categ = 'period_orig', trans = c('log','none','none'), spatial = TRUE, temporal = TRUE, PNG = TRUE)
	m_ass(name = 'DPR_period-poly3(lat)', mo = m5, dat = d, fixed = c('N_nests','Latitude'),categ = 'period_orig', trans = c('log','none','none'), spatial = TRUE, temporal = TRUE, PNG = TRUE)
	
	
	# model outputs
	 om0 = m_out(name = "S3Aperdiod DPR simple linear", model = m0, round_ = 3, nsim = 5000, aic = FALSE, save_sim = paste0(wd, 'posteriory_simulations/'))
	 om1 = m_out(name = "S3Bperiod DPR interaction linear", model = m1, round_ = 3, nsim = 5000, aic = FALSE, save_sim = paste0(wd, 'posteriory_simulations/'))
	 om4 = m_out(name = "S3Cperiod DPR simple poly3", model = m4, round_ = 3, nsim = 5000, aic = FALSE, save_sim = paste0(wd, 'posteriory_simulations/'))
	 om5 = m_out(name = "S3Dperiod DPR interaction poly3", model = m5, round_ = 3, nsim = 5000, aic = FALSE, save_sim = paste0(wd, 'posteriory_simulations/'))

    
# TPR
	# simple 	
     m0 = lmer(TPR ~ log( N_nests) +hemisphere+ period_orig+lat_abs + (1|site)+(1|species),  data = d)  
   
	# interaction linear
     m1 = lmer(TPR ~ log( N_nests) + hemisphere*period_orig*lat_abs +(1|site)+(1|species),  data = d)
	
	# simple 3rd polynomial
    m4 = lmer(TPR ~ log( N_nests) + period_orig+poly(Latitude,3) +(1|site)+(1|species),  data = d) 
	
	# interaction 3rd polynomial
    m5 = lmer(TPR ~ log( N_nests) + period_orig*poly(Latitude,3) +(1|site)+(1|species),  data = d)
  
	# model assumptions
		m_ass(name = 'TPR_period+hem+abs(lat)', mo = m0, dat = d, fixed = c('N_nests', 'lat_abs'),categ = c('hemisphere', 'period_orig'), trans = c('log','none','none'), spatial = TRUE, temporal = TRUE, PNG = TRUE)
	m_ass(name = 'TPR_period-hem-abs(lat)', mo = m1, dat = d, fixed = c('N_nests', 'lat_abs'),categ = c('hemisphere', 'period_orig'), trans = c('log','none','none'), spatial = TRUE, temporal = TRUE, PNG = TRUE)
	m_ass(name = 'TPR_period+poly3(lat)', mo = m4, dat = d, fixed = c('N_nests','Latitude'),categ = 'period_orig', trans = c('log','none','none'), spatial = TRUE, temporal = TRUE, PNG = TRUE)
	m_ass(name = 'TPR_period-poly3(lat)', mo = m5, dat = d, fixed = c('N_nests','Latitude'),categ = 'period_orig', trans = c('log','none','none'), spatial = TRUE, temporal = TRUE, PNG = TRUE)
	
	# model outputs
	 om0t = m_out(name = "S3Aperiod TPR simple linear", model = m0, round_ = 3, nsim = 5000, aic = FALSE, save_sim = paste0(wd, 'posteriory_simulations/'))
	 om1t= m_out(name = "S3Bperiod TPR interaction linear", model = m1, round_ = 3, nsim = 5000, aic = FALSE, save_sim = paste0(wd, 'posteriory_simulations/'))
	 om4t = m_out(name = "S3Cperiod TPRsimple poly3", model = m4, round_ = 3, nsim = 5000, aic = FALSE, save_sim = paste0(wd, 'posteriory_simulations/'))
	 om5t = m_out(name = "S3Dperiod TPRinteraction poly3", model = m5, round_ = 3, nsim = 5000, aic = FALSE, save_sim = paste0(wd, 'posteriory_simulations/'))
	 #om3$AIC = NA
	 #om4 = m_out(name = "interaction poly >2000 A+T", model = m4, round_ = 3, nsim = 5000, aic = FALSE)
	 #om4$AIC = NA
    
# EXPORT model output
  l = list()
  l[['dpr']] = rbind(om0,om1, om4,om5)
  l[['tpr']] = rbind(om0t,om1t, om4t,om5t)
           
  sname = 'Table_S3period'
  tmp = write_xlsx(l, paste0(outdir,sname,'.xlsx'))
  #openFile(tmp)   
  #shell(sname)