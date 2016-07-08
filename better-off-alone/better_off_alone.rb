# better off alone
use_bpm 137

live_loop :opening do
  sample :drum_splash_soft, rate: -0.775, finish: 0.75, amp: 0.75
  use_synth :pnoise
  with_fx :ixi_techno, phase: 8, phase_offset: 0.4, cutoff_min: 79, cutoff_max: 129, amp: 2 do
    with_fx :rhpf, cutoff: 115, res: 0.8, reps: 18 do
      play :E1, release: 0.125
      sleep 0.25
    end
  end
  sleep 127.5
end

live_loop :main_synth do
  sleep 4
  use_synth :dsaw
  use_synth_defaults cutoff: 115, detune: 0.05, sustain: 0.3, release: 0.2, amp: 0.9
  with_fx :ixi_techno, phase: 256, cutoff_min: 95, res: 0 do |ixi|
    with_fx :echo, mix: 0.07, phase: 1, decay: 8 do
      with_fx :reverb, mix: 0.2, room: 0.3, damp: 0.4 do
        2.times do
          play_pattern_timed [:B4, :As4, :B4], [7.5, 0.5, 8]
        end
        2.times do
          play_pattern_timed [:B4, :B4, :Gs4, :Fs5, :Fs5, :Ds5,
                              :B4, :B4, :Gs4, :E5, :E5, :Ds5], [1, 0.5, 4.5, 0.75, 0.75, 0.5]
        end
        2.times do
          play_pattern_timed [:B4, :B4, :Gs4, :B4, :B4, :As4, :Fs4, :Fs5, :Fs5, :Ds5,
                              :B4, :B4, :Gs4, :B4, :B4, :As4, :Fs4, :E5, :E5, :Ds5], [1, 0.5, 1, 1, 1, 1, 0.5, 0.75, 0.75, 0.5], release: 0.225
        end
        control ixi, mix: 0
        2.times do
          play_pattern_timed [:B4, :B4, :Gs4, :B4, :B4, :As4, :Fs4, :Fs5, :Fs5, :Ds5,
                              :B4, :B4, :Gs4, :B4, :B4, :As4, :Fs4, :E5, :E5, :Ds5], [1, 0.5, 1, 1, 1, 1, 0.5, 0.75, 0.75, 0.5], release: 0.225
        end
      end
    end
  end
end

def bass
  play_pattern_timed [:E1, :E2, :E1, :E2, :E1, :E2, :E1, :E2, :Ds1, :Ds2, :Ds1, :Ds2, :Ds1, :Ds2, :Ds1, :Ds2,
                      :Gs1, :Gs2, :Gs1, :Gs2, :Gs1, :Gs2, :Gs1, :Gs2, :Fs1, :Fs2, :Fs1, :Fs2, :Fs1, :Fs2, :Fs1, :Fs2], [0.5]
  play_pattern_timed [:E1, :E2, :E1, :E2, :E1, :E2, :E1, :E2, :Ds1, :Ds2, :Ds1, :Ds2, :Ds1, :Ds2, :Ds1, :Ds2,
                      :Gs1, :Gs2, :Gs1, :Gs2, :Gs1, :Gs2, :Gs1, :Gs2], [0.5]
  play_pattern_timed [:Fs1, :Fs2, :Fs2, :Fs2, :Fs2], [0.5, 1, 1, 1]
end

live_loop :bass do
  sleep 4
  use_synth :dsaw
  use_synth_defaults release: 0.225, res: 0, cutoff: 70, detune: 0, amp: 0.4
  2.times do
    bass
  end
  sleep 32
  bass
end

live_loop :sub_bass do
  sleep 4
  use_synth_defaults release: 0.2, env_curve: 1
  with_fx :normaliser, level: 0.2 do
    2.times do
      bass
    end
    sleep 32
    bass
  end
end

live_loop :kick do
  sleep 1
  2.times do
    sleep 3
    29.times do
      sample :bd_haus
      sleep 1
    end
  end
  sleep 35
  29.times do
    sample :bd_haus
    sleep 1
  end
  sleep 3
end

live_loop :hihat do # hi-hat inspiration from Jindřich Mynarz
  use_synth :pnoise
  sleep 20
  with_fx :rhpf, cutoff: 122, res: 0.75, reps: 24 do
    play :E1, attack: 0.01, decay: 0.04, release: 0.05, amp: 0.6 if (spread 3, 4, rotate: 2).tick
    sleep 0.5
  end
  sleep 4
  with_fx :rhpf, cutoff: 122, res: 0.75, reps: 56 do
    play :E1, attack: 0.01, decay: 0.04, release: 0.05, amp: 0.6 if (spread 3, 4, rotate: 2).tick
    sleep 0.5
  end
  sleep 36
  with_fx :rhpf, cutoff: 122, res: 0.75, reps: 56 do
    play :E1, attack: 0.01, decay: 0.04, release: 0.05, amp: 0.6 if (spread 3, 4, rotate: 2).tick
    sleep 0.5
  end
  sleep 4
end

live_loop :drumroll do
  sleep 84
  with_fx :ixi_techno, phase: 32, res: 0.9, cutoff_min: 0, cutoff_max: 129 do
    64.times do
      sample :sn_dolf, amp: 0.2, start: 0.1, finish: 0.4
      sleep 0.25
    end
  end
end

live_loop :snare do
  with_fx :normaliser, reps: 2, level: 0.1 do |rev|
    sleep 36
    with_fx :rhpf, reps: 14 do
      sleep 1
      sample :sn_dolf, start: 0.1, finish: 0.4
      sleep 1
    end
    control rev, level: 0.2
  end
  sleep 4
end

live_loop :filter_synth do
  sleep 100
  use_synth :tb303
  use_synth_defaults release: 0.2, res: 0.9, cutoff_min: 110, cutoff: 130
  amps = [0.1, 1, 0.1, 0.5, 0.5]
  notes = [:E2, :Ds2, :Gs2, :Fs2]
  sleeps = [0.5, 0.25, 0.5, 0.25, 0.5]
  with_fx :ixi_techno, phase: 32, reps: 2, amp: 1.2 do
    notes.each do |n|
      2.times do
        amps.each do |a|
          play n, amp: a
          s = sleeps.shift
          sleep sleeps.push(s).last
        end
      end
    end
  end
end

def thick_pad(note, key)
  use_synth :supersaw
  use_synth_defaults res: 0, cutoff: 100, sustain: 2, release: 2, attack: 2, amp: 0.3
  with_fx :reverb, mix: 0.5, room: 0.5, damp: 0.5 do
    with_fx :rhpf, cutoff: 65, res: 0.9 do
      play chord(note, key, num_octaves: 3)
      with_synth :dsaw do
        play chord(note, key, num_octaves: 3)
      end
      sleep 4
    end
  end
end

live_loop :pad do
  sleep 68
  with_fx :ixi_techno, phase: 64, cutoff_min: 80, cutoff_max: 129 do
    4.times do
      thick_pad(:E2, :major)
      thick_pad(:Ds2, :minor)
      thick_pad(:Gs2, :minor)
      thick_pad(:Fs2, :major)
    end
  end
end
