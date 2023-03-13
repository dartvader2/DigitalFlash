;; DigitalFlash
;; Cultivated by NoCodeClarity, Inc.
;; Dedicated to the responsible explorers 

(define-public (execute-flash-loan amount asset)
  (begin
    (assert (>= (get-balance asset) amount))
    (let ((balance-before (get-balance asset)))
      (call-contract
        (concat (buff 0x) asset)
        "flashLoan"
        (tuple (buff 0x) amount)
      )
      (let ((balance-after (get-balance asset)))
        (assert (= balance-before balance-after))
        (call-contract
          (concat (buff 0x) asset)
          "executeTrade"
          (tuple (buff 0x) amount)
        )
      )
      (call-contract
        (concat (buff 0x) asset)
        "repayFlashLoan"
        (tuple (buff 0x) amount)
      )
    )
  )
)
