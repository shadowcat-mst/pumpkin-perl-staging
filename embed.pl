#!/usr/bin/perl -w

require 5.003;

# XXX others that may need adding
#       warnhook
#       hints
#       copline
my @extvars = qw(sv_undef sv_yes sv_no na dowarn
                 curcop compiling 
                 tainting tainted stack_base stack_sp sv_arenaroot
                 curstash DBsub DBsingle debstash
                 rsfp 
                 stdingv
		 defgv
		 errgv
		 rsfp_filters
		 perldb
		 diehook
		 dirty
		 perl_destruct_level
                );

sub readsyms (\%$) {
    my ($syms, $file) = @_;
    local (*FILE, $_);
    open(FILE, "< $file")
	or die "embed.pl: Can't open $file: $!\n";
    while (<FILE>) {
	s/[ \t]*#.*//;		# Delete comments.
	if (/^\s*(\S+)\s*$/) {
	    my $sym = $1;
	    warn "duplicate symbol $sym while processing $file\n"
		if exists $$syms{$sym};
	    $$syms{$sym} = 1;
	}
    }
    close(FILE);
}

readsyms %global, 'global.sym';
readsyms %global, 'pp.sym';

sub readvars(\%$$) {
    my ($syms, $file,$pre) = @_;
    local (*FILE, $_);
    open(FILE, "< $file")
	or die "embed.pl: Can't open $file: $!\n";
    while (<FILE>) {
	s/[ \t]*#.*//;		# Delete comments.
	if (/PERLVARI?C?\($pre(\w+)/) {
	    my $sym = $1;
	    warn "duplicate symbol $sym while processing $file\n"
		if exists $$syms{$sym};
	    $$syms{$sym} = 1;
	}
    }
    close(FILE);
}

my %intrp;
my %thread;

readvars %intrp,  'intrpvar.h','I';
readvars %thread, 'thrdvar.h','T';
readvars %globvar, 'perlvars.h','G';

foreach my $sym (sort keys %intrp)
 {
  if (exists $global{$sym})
   {
    delete $global{$sym};
    warn "$sym in {global,pp}.sym as well as intrpvar.h\n";
   }
 }

foreach my $sym (sort keys %globvar)
 {
  if (exists $global{$sym})
   {
    delete $global{$sym};
    warn "$sym in {global,pp}.sym as well as perlvars.h\n";
   }
 }

foreach my $sym (sort keys %thread)
 {
  warn "$sym in intrpvar.h as well as thrdvar.h\n" if exists $intrp{$sym};
  if (exists $global{$sym})
   {
    delete $global{$sym};
    warn "$sym in {global,pp}.sym as well as thrdvar.h\n";
   }
 }

sub hide ($$) {
    my ($from, $to) = @_;
    my $t = int(length($from) / 8);
    "#define $from" . "\t" x ($t < 3 ? 3 - $t : 1) . "$to\n";
}
sub embed ($) {
    my ($sym) = @_;
    hide($sym, "Perl_$sym");
}
sub embedobj ($) {
    my ($sym) = @_;
    hide($sym, $sym =~ /^perl_/i ? "CPerlObj::$sym" : "CPerlObj::Perl_$sym");
}
sub embedvar ($) {
    my ($sym) = @_;
#   hide($sym, "Perl_$sym");
    return '';
}

sub multon ($$$) {
    my ($sym,$pre,$ptr) = @_;
    hide("PL_$sym", "($ptr$pre$sym)");
}
sub multoff ($$) {
    my ($sym,$pre) = @_;
    return hide("PL_$pre$sym", "PL_$sym");
}

unlink 'embed.h';
open(EM, '> embed.h')
    or die "Can't create embed.h: $!\n";

print EM <<'END';
/* !!!!!!!   DO NOT EDIT THIS FILE   !!!!!!! 
   This file is built by embed.pl from global.sym, pp.sym, intrpvar.h,
   and thrdvar.h.  Any changes made here will be lost!
*/

/* (Doing namespace management portably in C is really gross.) */

/* NO_EMBED is no longer supported. i.e. EMBED is always active. */

/* Hide global symbols */

#if !defined(PERL_OBJECT)

END

for $sym (sort keys %global) {
    print EM embed($sym);
}

print EM <<'END';

#else	/* PERL_OBJECT */

END

# XXX these should be in a *.sym file
my @extras = qw(
    perl_init_i18nl10n
    perl_init_i18nl14n
    perl_new_collate
    perl_new_ctype
    perl_new_numeric
    perl_set_numeric_local
    perl_set_numeric_standard
    perl_construct
    perl_destruct
    perl_atexit
    perl_free
    perl_parse
    perl_run
    perl_get_sv
    perl_get_av
    perl_get_hv
    perl_get_cv
    perl_call_argv
    perl_call_pv
    perl_call_method
    perl_call_sv
    perl_eval_pv
    perl_eval_sv
    perl_require_pv

    hsplit
    hfreeentries
    more_he
    new_he
    del_he
    save_hek
    mess_alloc
    gv_init_sv
    save_scalar_at
    asIV
    asUV
    more_sv
    more_xiv
    more_xnv
    more_xpv
    more_xrv
    new_xiv
    new_xnv
    new_xpv
    new_xrv
    del_xiv
    del_xnv
    del_xpv
    del_xrv
    sv_mortalgrow
    sv_unglob
    sv_check_thinkfirst
    avhv_index_sv
    do_report_used
    do_clean_objs
    do_clean_named_objs
    do_clean_all
    not_a_number
    my_safemalloc
    visit
    qsortsv
    sortcv
    save_magic
    magic_methpack
    magic_methcall
    magic_methcall
    doform
    doencodes
    refto
    seed
    docatch
    dofindlabel
    doparseform
    dopoptoeval
    dopoptolabel
    dopoptoloop
    dopoptosub
    dopoptosub_at
    save_lines
    doeval
    amagic_cmp
    amagic_cmp_locale
    mul128
    is_an_int
    div128
    runops_standard
    runops_debug
    check_uni
    force_next
    force_version
    force_word
    tokeq
    scan_const
    scan_formline
    scan_heredoc
    scan_ident
    scan_inputsymbol
    scan_pat
    scan_str
    scan_subst
    scan_trans
    scan_word
    skipspace
    checkcomma
    force_ident
    incline
    intuit_method
    intuit_more
    lop
    missingterm
    no_op
    set_csh
    sublex_done
    sublex_push
    sublex_start
    uni
    filter_gets
    new_constant
    ao
    depcom
    win32_textfilter
    incl_perldb
    isa_lookup
    get_db_sub
    list_assignment
    bad_type
    modkids
    no_fh_allowed
    scalarboolean
    too_few_arguments
    too_many_arguments
    null
    pad_findlex
    newDEFSVOP
    gv_ename
    cv_clone2
    find_beginning
    forbid_setid
    incpush
    init_interp
    init_ids
    init_debugger
    init_lexer
    init_main_stash
    init_perllib
    init_postdump_symbols
    init_predump_symbols
    my_exit_jump
    nuke_stacks
    open_script
    usage
    validate_suid
    emulate_eaccess
    reg
    reganode
    regatom
    regbranch
    regc
    reguni
    regclass
    regclassutf8
    regcurly
    reg_node
    regpiece
    reginsert
    regoptail
    regset
    regtail
    regwhite
    nextchar
    dumpuntil
    scan_commit
    study_chunk
    add_data
    re_croak2
    regmatch
    regrepeat
    regrepeat_hard
    regtry
    reginclass
    reginclassutf8
    regcppush
    regcppop
    regcp_set_to
    cache_re
    reghop
    reghopmaybe
    dump
    do_aspawn
    debprof
    bset_obj_store
    new_logop
    do_trans_CC_simple
    do_trans_CC_count
    do_trans_CC_complex
    do_trans_UU_simple
    do_trans_UU_count
    do_trans_UU_complex
    do_trans_UC_simple
    do_trans_CU_simple
    do_trans_UC_trivial
    do_trans_CU_trivial
    unwind_handler_stack
    restore_magic
    restore_rsfp
    restore_expect
    restore_lex_expect
    yydestruct
    del_sv
    fprintf
);

my %skip;

for $sym (qw[
    utf8skip
	  ])
{
    $skip{$sym}++;
}

for $sym (sort(keys(%global),@extras)) {
    next if exists $skip{$sym};
    print EM embedobj($sym);
}

print EM <<'END';

#endif	/* PERL_OBJECT */

END

close(EM);

unlink 'embedvar.h';
open(EM, '> embedvar.h')
    or die "Can't create embedvar.h: $!\n";

print EM <<'END';
/* !!!!!!!   DO NOT EDIT THIS FILE   !!!!!!! 
   This file is built by embed.pl from global.sym, pp.sym, intrpvar.h,
   and thrdvar.h.  Any changes made here will be lost!
*/

/* (Doing namespace management portably in C is really gross.) */

/* Put interpreter-specific symbols into a struct? */

#ifdef MULTIPLICITY

#ifndef USE_THREADS
/* If we do not have threads then per-thread vars are per-interpreter */

END

for $sym (sort keys %thread) {
    print EM multon($sym,'T','PL_curinterp->');
}

print EM <<'END';

#endif /* !USE_THREADS */

/* These are always per-interpreter if there is more than one */

END

for $sym (sort keys %intrp) {
    print EM multon($sym,'I','PL_curinterp->');
}

print EM <<'END';

#else	/* !MULTIPLICITY */

END

for $sym (sort keys %intrp) {
    print EM multoff($sym,'I');
}

print EM <<'END';

#ifndef USE_THREADS

END

for $sym (sort keys %thread) {
    print EM multoff($sym,'T');
}

print EM <<'END';

#endif /* USE_THREADS */

/* Hide what would have been interpreter-specific symbols? */

END

for $sym (sort keys %intrp) {
    print EM embedvar($sym);
}

print EM <<'END';

#ifndef USE_THREADS

END

for $sym (sort keys %thread) {
    print EM embedvar($sym);
}

print EM <<'END';

#endif /* USE_THREADS */
#endif /* MULTIPLICITY */

/* Now same trickey for per-thread variables */

#ifdef USE_THREADS

END

for $sym (sort keys %thread) {
    print EM multon($sym,'T','thr->');
}

print EM <<'END';

#endif /* USE_THREADS */

#ifdef PERL_GLOBAL_STRUCT

END

for $sym (sort keys %globvar) {
    print EM multon($sym,'G','PL_Vars.');
}

print EM <<'END';

#else /* !PERL_GLOBAL_STRUCT */

END

for $sym (sort keys %globvar) {
    print EM multoff($sym,'G');
}

print EM <<'END';

END

for $sym (sort keys %globvar) {
    print EM embedvar($sym);
}

print EM <<'END';

#endif /* PERL_GLOBAL_STRUCT */

END

print EM <<'END';

#if 0 /* ndef MIN_PERL_DEFINE */	/* unsupported in 5.006 */

END

for $sym (sort @extvars) {
    print EM hide($sym,"PL_$sym");
}

print EM <<'END';

#endif /* MIN_PERL_DEFINE */
END


close(EM);
